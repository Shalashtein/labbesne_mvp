module Spree::Admin::ProductsControllerDecorator

  def create
    super
    byebug
  end

  def update
    super
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

  Spree::Admin::ProductsController.prepend self
end
