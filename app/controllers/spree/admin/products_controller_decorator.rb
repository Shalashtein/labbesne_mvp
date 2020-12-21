module Spree::Admin::ProductsControllerDecorator

  def create
    super
  end

  def index
    session[:return_to] = request.url
    respond_with(@collection)
  end

  def unapproved
    @unapproved = Spree::Product.all.select { |p| p.approved? }
  end

  Spree::Admin::ProductsController.prepend self
end
