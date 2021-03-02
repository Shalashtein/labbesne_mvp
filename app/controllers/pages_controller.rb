class PagesController < ApplicationController
  class << self
    include Rails.application.routes.url_helpers
  end
  layout :resolve_layout
  before_action :signinRouter, except: %i[landing guestSwiped confirm_email_signup resend_confirmation_email]
  before_action :setCart, except: %i[landing guestSwiped confirm_email_signup resend_confirmation_email]
  before_action :setProducts, only: %i[store deck landing recommendation_skip]
  before_action :setStylist, only: %i[stylist stylist_outfits_area stylist_products_area]
  before_action :setOutfitProduct, only: %i[stylist stylist_outfits_area stylist_products_area stylist_filter]

  # LANDING #############################################################

  def landing
    redirect_to root_path if spree_user_signed_in?
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
    if current_spree_user.milestone == true
      render partial: 'pages/recommendation_milestone'
    else
      render partial: 'pages/partials/deck'
    end
  end

  def recommendation_skip
    current_spree_user.milestone = false
    current_spree_user.save!
    render partial: 'pages/partials/deck'
  end

  def preference
    interaction = Interaction.where(spree_product_id: params[:data][:product].to_i,
                                    spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:data][:product].to_i,
                                                                                                      spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
    interaction.save!
    UpdatePreferencesJob.perform_later(params[:data][:product].to_i, current_spree_user.id, params[:data][:action],
                                       interaction.id)
    if current_spree_user.profile.swiped % 100 == 0
      current_spree_user.milestone = true
      current_spree_user.save!
    end
  end

  def recommendation_milestone
  end

  def swipepage
    @products = Spree::Product.where(test: true, gender: current_spree_user.profile.info.gender.capitalize)
  end

  def expandedInfo
    interaction = Interaction.where(spree_product_id: params[:product].to_i,
                                    spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:product].to_i,
                                                                                                      spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
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
      interaction = Interaction.where(spree_product_id: params[:product].to_i,
                                      spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:product].to_i,
                                                                                                        spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
      interaction.saved = true
      interaction.save!
      puts interaction.pretty_inspect
    else
      interaction = Interaction.where(spree_product_id: params[:product].to_i,
                                      spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:product].to_i,
                                                                                                        spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
      interaction.saved = false
      interaction.save!
      puts interaction.pretty_inspect
    end
    respond_to do |format|
      format.json { render json: interaction.saved }
    end
  end

  def updateAddress
    current_spree_user.ship_address.address1 = params[:geo]
    current_spree_user.bill_address.address1 = params[:geo]
    current_spree_user.ship_address.address2 = params[:address2]
    current_spree_user.bill_address.address2 = params[:address2]
    current_spree_user.ship_address.lng = params[:lng]
    current_spree_user.ship_address.lat = params[:lat]
    current_spree_user.bill_address.lng = params[:lng]
    current_spree_user.bill_address.lat = params[:lat]
    @order.special_instructions = params[:instructions]
    @order.save!
    current_spree_user.ship_address.save!
    current_spree_user.bill_address.save!
    @order.next if @order.state == 'cart'
    @order.next if @order.state == 'address'
    @order.next if @order.state == 'delivery'
    @order.next if @order.state == 'payment'
  end

  def savedAddress
    @order.next if @order.state == 'cart'
    @order.next if @order.state == 'address'
    @order.next if @order.state == 'delivery'
    @order.next if @order.state == 'payment'
  end

  def checkout
    respond_to do |format|
      if current_spree_user.ship_address.nil?
        format.json { render json: { "value" => "none" } }
      elsif current_spree_user.ship_address.address2.nil?
        format.json { render json: { "value" => "incomplete" } }
      else
        format.json { render json: { "value" => "complete" } }
      end
    end
  end

  def confirm
    render partial: 'pages/partials/confirm'
  end

  def finalize
    @shipments = @order.shipments
    makePaymentCOD
    @order.complete
  end

  def popupMessage
    if params[:message] == 'orderdone'
      @message = `Order Placed\n You can check its state in your closet`
    else
      @message = `What in God's name?`
    end
    render partial: 'pages/partials/message', locals: { message: @message }
  end

  # End of main store #############################################################
  #
  # Customer Dashboard #############################################################

  def customer
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete').where.not(
      shipment_state: 'shipped', state: 'returned'
    ).order(created_at: :desc)
  end

  def customerOrders
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete').where.not(
      shipment_state: 'shipped', state: 'returned'
    ).order(created_at: :desc)
    render partial: 'pages/partials/customer/orders'
  end

  def customerProducts
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete', shipment_state: 'shipped',
                                 payment_state: 'paid').where.not(state: 'returned').order(created_at: :desc)
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
    li.quantity = 1
    li.save
  end

  # End of Customer Dashboard #############################################################
  #
  # Vendor Dashboard #############################################################

  def vendor
    @shipments = Spree::Shipment.where(stock_location_id: current_spree_user.stock_locations.first.id,
                                       state: "pending").joins(:order).where(spree_orders: { state: 'complete' }).order(created_at: :asc)
  end

  def vendor_orders
    @shipments = Spree::Shipment.where(stock_location_id: current_spree_user.stock_locations.first.id,
                                       state: "pending").joins(:order).where(spree_orders: { state: 'complete' }).order(created_at: :asc)
    render partial: 'pages/partials/vendor/orders'
  end

  def vendor_order_ready
    szabre = Spree::Shipment.find(params[:s])
    szabre.order.vendor_state = true
    szabre.order.save!
    szabre.update_state if Spree::Shipment.find(params[:s]).state == 'pending'
  end

  def slip
    @shipment = Spree::Shipment.find(params[:s])
    @order = @shipment.order
    @customer = Spree::User.find(@order.user_id)
    @ship_barcode = Barby::Code128B.new(@shipment.number).to_png(height: 100)
    @order_barcode = Barby::Code128A.new(@order.number).to_image(height: 60)
    @vendor = Spree::User.find(@shipment.stock_location.spree_user_id)
  end

  def vendor_info
    if current_spree_user.profile.nil?
      p = Profile.new(spree_user_id: current_spree_user.id)
      p.save!
    end
    @info = current_spree_user.profile.info.nil? ? Info.new : current_spree_user.profile.info
    render partial: 'pages/partials/vendor/info'
  end

  def vendor_products
    @image = Spree::Image.new
    @products = Spree::Product.where(spree_user_id: current_spree_user).order(created_at: :desc).page(params[:page]).per(5)
    @p = Spree::Product.new
    render partial: 'pages/partials/vendor/products'
  end

  def vendor_search
    if params[:sku] == ''
      @products = Spree::Product.where(spree_user_id: current_spree_user).page(params[:page]).per(5)
    else
      @products = Spree::Product.where(spree_user_id: current_spree_user,
                                       vendorSKU: params[:sku]).page(params[:page]).per(5)
    end
    render partial: 'pages/partials/vendor/products_list'
  end

  def edit_product
    product = Spree::Product.find(params[:p])
    case params[:type]
    when 'name'
      product.name = params[:val]
      product.save!
    when 'vendorSKU'
      product.vendorSKU = params[:val]
      product.save!
    when 'price'
      product.price = params[:value]
      product.save!
    when 'gender'
      product.gender = params[:val]
      product.save!
    when 'brand'
      pp = Spree::ProductProperty.find_or_create_by(product_id: product.id,
                                                    property_id: Spree::Property.find_by(name: 'Brand').id)
      pp.value = params[:val]
      pp.save!
    when 'fabric'
      pp = Spree::ProductProperty.find_or_create_by(product_id: product.id,
                                                    property_id: Spree::Property.find_by(name: 'Fabric').id)
      pp.value = params[:val]
      pp.save!
    when 'sizes'
      pp = Spree::ProductProperty.find_or_create_by(product_id: product.id,
                                                    property_id: Spree::Property.find_by(name: 'Sizes').id)
      pp.value = params[:val]
      pp.save!
    when 'description'
      product.description = params[:val]
      product.save!
    when 'stock'
      stock = product.stock_items.find_by(stock_location_id: current_spree_user.stock_locations.first.id)
      stock.adjust_count_on_hand(params[:val].to_i)
      stock.save!
      product.save!
    end
  end

  def vendor_update_image
    Spree::Product.find(params[:p]).images.first.destroy
  end

  def create_product
    render partial: 'pages/partials/vendor/new_product'
  end

  def vendor_new_product
    name = params[:name]
    vendorSKU = params[:vendorSKU]
    price = params[:price]
    gender = params[:gender]
    product = Spree::Product.new
    brand = params[:brand]
    fabric = params[:fabric]
    sizes = params[:sizes]
    stock = params[:stock]
    description = params[:description]
    product.name = name
    product.vendorSKU = vendorSKU
    product.gender = gender
    product.price = price
    product.shipping_category = Spree::ShippingCategory.find_by(name: "Default")
    product.tax_category = Spree::TaxCategory.find_by(name: "Default")
    product.spree_user_id = current_spree_user.id
    product.description = description
    product.save!
    stock_items = product.stock_items.find_by(stock_location_id: current_spree_user.stock_locations.first.id)
    stock_items.adjust_count_on_hand(stock.to_i)
    stock_items.save!
    pp = Spree::ProductProperty.find_or_create_by(product_id: product.id,
                                                  property_id: Spree::Property.find_by(name: 'Brand').id)
    pp.value = brand
    pp.save!
    pp = Spree::ProductProperty.find_or_create_by(product_id: product.id,
                                                  property_id: Spree::Property.find_by(name: 'Fabric').id)
    pp.value = fabric
    pp.save!
    pp = Spree::ProductProperty.find_or_create_by(product_id: product.id,
                                                  property_id: Spree::Property.find_by(name: 'Sizes').id)
    pp.value = sizes
    pp.save!
    respond_to do |format|
      format.json do
        render json: { "vid" => product.variants_including_master.first.id, "id" => product.id }, status: 200
      end
    end
  end

  def vendor_analytics
    render partial: 'pages/partials/vendor/analytics'
  end

  def vendor_info_change
    @location = Spree::StockLocation.find_by(spree_user_id: current_spree_user.id)
    case params[:input]
    when "name"
      @location.admin_name = params[:value]
      @location.save!
    when "phone"
      @location.phone = params[:value]
      @location.save!
    when "address"
      @location.address1 = params[:value]
      @location.save!
    end
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
      @products = Spree::Product.joins(:product_specs).where(approved: true,
                                                             product_specs: { name: 'clothing-type',
                                                                              value: 'top' }).page((params[:page].to_i - 1).to_s).per(6)
    when 'pants'
      @products = Spree::Product.joins(:product_specs).where(approved: true,
                                                             product_specs: { name: 'clothing-type',
                                                                              value: 'pants' }).page((params[:page].to_i - 1).to_s).per(6)
    when 'shoes'
      @products = Spree::Product.joins(:product_specs).where(approved: true,
                                                             product_specs: { name: 'clothing-type',
                                                                              value: 'shoes' }).page((params[:page].to_i - 1).to_s).per(6)
    when 'accessories'
      @products = Spree::Product.joins(:product_specs).where(approved: true,
                                                             product_specs: { name: 'clothing-type',
                                                                              value: 'accessory' }).page((params[:page].to_i - 1).to_s).per(6)
    else
      @products = Spree::Product.where(approved: true).page(params[:page]).per(6)
    end
    render partial: 'pages/partials/outfit_products'
  end

  def resend_confirmation_email
    user = Spree::User.find(session[:user_id])
    user.send_confirmation_instructions
  end

  # End of stylist dashboard #############################################################
  #
  # Shared #############################################################

  private

  def confirm_email_signup
  end

  def signinRouter
    unless spree_user_signed_in?
      respond_to do |format|
        format.html { redirect_to landing_path }
      end
    end
  end

  def setCart
    @order = current_spree_user.last_incomplete_spree_order || Spree::Order.create(user_id: current_spree_user.id)
  end

  def setProducts
    @products_sorted = Spree::Product.where(approved: true).order(swiped: :desc, id: :desc)
    filterGender
    if params[:current_page].to_i == @products_sorted.page(1).total_pages
      @products_sorted = @products_sorted.page(1).per(10)
    else
      @products_sorted = @products_sorted.page(params[:page]).per(10)
    end
    filterGender
  end

  def filterGender
    unless params[:gender].nil?
      gender = if params[:gender] == 'male'
                 'Men'
               else
                 params[:gender] == 'female' ? 'Women' : 'Unisex'
               end
      @products_sorted = @products_sorted.where(gender: gender) unless gender == 'Unisex'
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
    @shipments.each do |s|
      payment = Spree::Payment.new
      payment.payment_method_id = Spree::PaymentMethod.where(name: 'Cash on Delivery').first.id
      payment.order_id = @order.id
      payment.amount = s.total_with_items
      payment.save!
    end
    @order.save
  end

  def resolve_layout
    case action_name
    when "store"
      "application"
    when "landing"
      "landing"
    when "slip"
      "slip"
    when "confirm_email_signup"
      "slip"
    when "recommendation_milestone"
      "slip"
    else
      "application"
    end
  end
end
