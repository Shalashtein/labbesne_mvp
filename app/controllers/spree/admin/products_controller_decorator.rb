module Spree::Admin::ProductsControllerDecorator

  def create
    super
  end

  def update
    super
    if @product.sku.empty?
      @product.sku = skuGenerator(@product.id)
    end
    @product.save
  end

  def index
    session[:return_to] = request.url
    respond_with(@collection)
  end

  def unapproved
    return @unapproved if @unapproved
    @unapproved = Spree::Product.where(approved: false)
  end

  def tracks
    if Track.any?
      @tracks = if current_spree_user.has_spree_role?(:admin)
                  Track.where(recieved: false)
                else
                  Track.where(spree_user_id: current_spree_user.id, recieved: false)
                end
    else
      @tracks = []
    end
  end

  def vendor
    @search = Spree::Product.ransack(spree_user_id: current_spree_user)
    @collection = Spree::Product.where(spree_user_id: current_spree_user.id)
  end

  def skuGenerator(product_id)
    p = Spree::Product.find(product_id)
    return "L#{p.gender[0].capitalize}#{p.spree_user_id}#{p.id.to_s.rjust(8, '0')}"
  end

  Spree::Admin::ProductsController.prepend self
end
