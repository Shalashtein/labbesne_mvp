module Spree::Admin::ProductsControllerDecorator

  def self.prepended(base)
    def vendor
      session[:return_to] = request.url
      @search = Spree::Product.ransack(spree_user_id: current_spree_user)
      @collection = Spree::Product.where(spree_user_id: current_spree_user.id)
    end
  end

  def create
    super
  end

  def index
    session[:return_to] = request.url
    respond_with(@collection)
  end

  def unapproved
    @search = Spree::Product.ransack(approved: false)
    @unapproved = Spree::Product.where(approved: false)
  end



  Spree::Admin::ProductsController.prepend self
end
