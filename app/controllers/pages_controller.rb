class PagesController < ApplicationController
  def home
  end

  def vendorDashboard
    @current_user = current_spree_user
    @product = Spree::Product.new
    @shipping = Spree::ShippingCategory.find(1)
    @products = Spree::Product.where(spree_user_id: current_spree_user.id)
  end
end
