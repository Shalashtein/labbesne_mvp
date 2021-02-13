class PagesController < ApplicationController
  layout 'application', only: "store"
  layout 'landing', only: 'landing'
  layout 'slip', only: 'slip'
  before_action :signinRouter, except: [:landing, :guestSwiped]
  before_action :setCart, except: [:landing, :guestSwiped]
  before_action :setProducts, only: [:store, :deck, :landing]
  before_action :setStylist, only: [:stylist, :stylist_outfits_area, :stylist_products_area]
  before_action :setOutfitProduct, only: [:stylist, :stylist_outfits_area, :stylist_products_area, :stylist_filter]

  # LANDING #############################################################

  def landing
    if spree_user_signed_in?
      redirect_to root_path
    end
    @preregistration = Preregistration.new
    @swiped = session[:swiped] || false
    if @swiped && !session[:email].nil?
      @email = session[:email]
    else
      @email = nil
    end
  end

  def guestSwiped
    session[:swiped] = true
  end

  # END OF LANDING #############################################################
  #
  # Profile Router #############################################################

  def profileRouter
    @measurements_progress = if current_spree_user.profile.body_measurement.nil?
                              0
                             else
                              100
                             end
    @lifestyle_progress = if current_spree_user.profile.lifestyle.nil?
                              0
                             else
                              100
                             end
    @info_progress = if current_spree_user.profile.info.nil?
                              0
                             else
                              100
                             end
  end

  # End of profile router #############################################################
  #
  # Main Store #############################################################

  def store
    @preference = ProfileSpec.new
    @item = Spree::LineItem.new
  end

  def deck
    render partial: 'pages/partials/deck'
  end

  def preference
    interaction = Interaction.where(spree_product_id: params[:data][:product].to_i, spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:data][:product].to_i, spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
    interaction.save!
    UpdatePreferencesJob.perform_later(params[:data][:product].to_i, current_spree_user.id, params[:data][:action], interaction.id)
  end

  def swipepage
    @products = Spree::Product.where(test: true, gender: current_spree_user.profile.info.gender.capitalize)
  end

  def expandedInfo
    interaction = Interaction.where(spree_product_id: params[:product].to_i, spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:product].to_i, spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
    interaction.expanded = true
    interaction.save!
    puts interaction.inspect
  end

  def removeItem
    li = Spree::LineItem.find(params[:item_id])
    @order.item_total -= li.price * li.quantity
    @order.total -= li.price * li.quantity
    @order.save
    li.destroy
    render partial: 'pages/partials/cart'
  end

  def emptyCart
    Spree::Order.find(params[:order_id]).empty!
    render partial: 'pages/partials/cart'
  end

  def returnCart
    render partial: 'pages/partials/cart'
  end

  def saveProduct
    product_id = params[:product].to_i
    action = params[:action_id] != 'true'
    if action
      interaction = Interaction.where(spree_product_id: params[:product].to_i, spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:data][:product].to_i, spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
      interaction.saved = true
      interaction.save!
      puts interaction.pretty_inspect
    else
      interaction = Interaction.where(spree_product_id: params[:product].to_i, spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:data][:product].to_i, spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
      interaction.saved = false
      interaction.save!
      puts interaction.pretty_inspect
    end
    respond_to do |format|
      format.json {interaction.to_json}
    end
  end

  def updateAddress
    current_spree_user.ship_address.address1 = params[:geo]
    current_spree_user.ship_address.address2 = params[:address2]
    current_spree_user.ship_address.lng = params[:lng]
    current_spree_user.ship_address.lat = params[:lat]
    @order.special_instructions = params[:instructions]
    @order.save!
    current_spree_user.ship_address.save!
    current_spree_user.ship_address.pretty_inspect
    @order.next if @order.state == 'cart'
    @order.next if @order.state == 'address'
    @order.next if @order.state == 'delivery'
    makePaymentCOD
    @order.next if @order.state == 'payment'
  end

  def savedAddress
    @order.next if @order.state == 'cart'
    @order.next if @order.state == 'address'
    @order.next if @order.state == 'delivery'
    makePaymentCOD
    @order.next if @order.state == 'payment'
  end

  def checkout
    respond_to do |format|
      if current_spree_user.ship_address.nil?
        format.json { render json: {"value" => "none"}}
      elsif current_spree_user.ship_address.address2.nil?
        format.json { render json: {"value" => "incomplete"}}
      else
        format.json { render json: {"value" => "complete"}}
      end
    end
  end

  def confirm
    render partial: 'pages/partials/confirm'
  end

  def finalize
    @order.line_items.each do |item|
      t = Track.new(spree_order_id: @order.id, spree_line_item_id: item.id, vendor_recieved: false, vendor_sent: false, recieved: false, quantity: item.quantity, spree_user_id: Spree::Product.find(Spree::Variant.find(item.variant_id).product_id).spree_user_id)
      t.save!
    end
    makePaymentCOD
    @order.complete
  end

  def popupMessage
    if params[:message] == 'orderdone'
      @message = `Order Placed\n You can check its state in your closet`
    else
      @message = `What in God's name?`
    end
    render partial: 'pages/partials/message', locals: {message: @message}
  end

  # End of main store #############################################################
  #
  # Customer Dashboard #############################################################

  def customer
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete').where.not(shipment_state: 'shipped', state: 'returned').order(created_at: :desc)
  end

  def customerOrders
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete').where.not(shipment_state: 'shipped', state: 'returned').order(created_at: :desc)
    render partial: 'pages/partials/customer/orders'
  end

  def customerProducts
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete', shipment_state: 'shipped', payment_state: 'paid').where.not(state: 'returned').order(created_at: :desc)
    render partial: 'pages/partials/customer/products'
  end

  def customerSaved
    @interactions = Interaction.where(spree_user_id: current_spree_user.id, saved: true)
    render partial: 'pages/partials/customer/saved'
  end

  def unsave
    interaction = Interaction.find(params[:i])
    interaction.saved = false
    interaction.save
    @interactions = Interaction.where(spree_user_id: current_spree_user.id, saved: true)
    render partial: 'pages/partials/customer/saved'
  end

  def closet_cart
    li = Spree::LineItem.new
    li.order_id = @order.id
    li.variant_id = params[:p]
    li.save
  end

  # End of Customer Dashboard #############################################################
  #
  # Vendor Dashboard #############################################################

  def vendor
    @products = @products || Spree::Product.where(spree_user_id: current_spree_user)
    # TODO change the id to current_spree_user
    @tracks = @tracks ||Track.where(spree_user_id: 2, recieved: false).joins(:order).where(spree_orders: {state: 'complete'}).group_by {|t| t.spree_order_id}
  end

  def vendor_order_ready
    Spree::LineItem.where(order_id: params[:o]).joins(:variant).joins(:product).where(spree_products: {spree_user_id: current_spree_user.id}).each do |li|
      track = Track.find_by(spree_line_item_id: li.id)
      track.vendor_recieved = true
      track.save
    end
  end

  def slip
    @order = Spree::Order.find(params[:o])
    @customer = Spree::User.find(@order.user_id)
    @tracks = Track.where(spree_order_id: params[:o], spree_user_id: params[:v]).joins(:item).uniq
    @ship_barcode = Barby::Code128B.new('Abe is my lord and saviour').to_png(height: 170)
    @order_barcode = Barby::Code128B.new(@order.number).to_png
  end

  def vendor_order_picked
    li = Spree::LineItem.find(params[:i])
    track = Track.find_by(spree_line_item_id: li.id)
    track.vendor_sent = true
    track.save
  end

  # End of vendor dashboard #############################################################
  #
  # Stylist Dashboard #############################################################

  def stylist

  end

  def stylist_outfits_area
    render partial: 'pages/partials/outfit_generator'
  end

  def stylist_products_area
    stylist_filter
  end

  def stylist_filter
    filter = params[:filter]
    case filter
      when 'tops'
        @products = Spree::Product.joins(:product_specs).where(approved: true, product_specs: {name: 'clothing-type', value: 'top'}).page((params[:page].to_i - 1).to_s).per(6)
      when 'pants'
        @products = Spree::Product.joins(:product_specs).where(approved: true, product_specs: {name: 'clothing-type', value: 'pants'}).page((params[:page].to_i - 1).to_s).per(6)
      when 'shoes'
        @products = Spree::Product.joins(:product_specs).where(approved: true, product_specs: {name: 'clothing-type', value: 'shoes'}).page((params[:page].to_i - 1).to_s).per(6)
      when 'accessories'
        @products = Spree::Product.joins(:product_specs).where(approved: true, product_specs: {name: 'clothing-type', value: 'accessory'}).page((params[:page].to_i - 1).to_s).per(6)
      else
        @products = Spree::Product.where(approved: true).page(params[:page]).per(6)
    end
    render partial: 'pages/partials/outfit_products'
  end

  # End of stylist dashboard #############################################################
  #
  # Shared #############################################################

  private
  def signinRouter
    if !spree_user_signed_in?
      redirect_to landing_path
    end
  end

  def setCart
    @order = current_spree_user.last_incomplete_spree_order || Spree::Order.new
  end

  def setProducts
    @products_sorted = Spree::Product.where(approved: true).except(Spree::Product.where(total_on_hand: 1..)).order(swiped: :desc, id: :desc)
    filterGender
    if params[:current_page].to_i == @products_sorted.page(1).total_pages
      @products_sorted = @products_sorted.page(1)
    else
      @products_sorted = @products_sorted.page(params[:page])
    end
    filterGender
  end

  def filterGender
    if !params[:gender].nil?
      gender = params[:gender] == 'male' ? 'Men' : params[:gender] == 'female' ? 'Women' : 'Unisex'
      if gender != 'Unisex'
        @products_sorted = @products_sorted.where(gender: gender)
      end
    end
  end

  def setStylist
    @products = Spree::Product.where(approved: true).page(params[:page]).per(6)
    @outfit = Outfit.new(spree_user_id: current_spree_user.id)
  end

  def setOutfitProduct
    @product_outfit = ProductOutfit.new
  end

  def makePaymentCOD
    payment = Spree::Payment.new
    payment.payment_method_id = Spree::PaymentMethod.where(name: 'Cash on Delivery').first.id
    payment.order_id = @order.id
    payment.amount = @order.total
    payment.save!
    @order.save
  end
end
