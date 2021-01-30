class PagesController < ApplicationController
  layout 'application', only: "store"
  before_action :signinRouter
  before_action :setCart
  before_action :setProducts, only: [:store, :deck]
  before_action :setStylist, only: [:stylist, :stylist_outfits_area, :stylist_products_area]
  before_action :setOutfitProduct, only: [:stylist, :stylist_outfits_area, :stylist_products_area, :stylist_filter]

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
    interaction = Interaction.where(spree_product_id: params[:product].to_i, spree_user_id: current_spree_user.id).first || Interaction.create(spree_product_id: params[:data][:product].to_i, spree_user_id: current_spree_user.id, swiped: false, like_count: 0, dislike_count: 0, expanded: false, bought: false)
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

  def customer
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete')
  end

  def customerOrders
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete')
    render partial: 'pages/partials/customer/orders'
  end

  def customerProducts
    @interactions = Interaction.where(spree_user_id: current_spree_user.id, saved: true)
    render partial: 'pages/partials/customer/products'
  end

  def customerSaved
    @orders = Spree::Order.where(user_id: current_spree_user.id, state: 'complete')
    render partial: 'pages/partials/customer/orders'
  end

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

  private
  def signinRouter
    if !spree_user_signed_in?
      redirect_to spree.login_path
    end
  end

  def setCart
    @order = current_spree_user.last_incomplete_spree_order || Spree::Order.new
  end

  def setProducts
    if params[:current_page].to_i == Spree::Product.where(approved: true).order(swiped: :desc, id: :desc).page(params[:page]).total_pages
      @products_sorted = Spree::Product.where(approved: true).except(Spree::Product.where(total_on_hand: 1..)).order(swiped: :desc, id: :desc).page(1)
    else
      @products_sorted = Spree::Product.where(approved: true).except(Spree::Product.where(total_on_hand: 1..)).order(swiped: :desc, id: :desc).page(params[:page])
    end
  end

  def setStylist
    @products = Spree::Product.where(approved: true).page(params[:page]).per(6)
    @outfit = Outfit.new(spree_user_id: current_spree_user.id)
  end

  def setOutfitProduct
    @product_outfit = ProductOutfit.new
  end
end
