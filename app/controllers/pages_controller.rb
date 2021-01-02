class PagesController < ApplicationController
  before_action :signinRouter

  def home
  end

  def profileRouter

  end

  def measurements

  end

  def vendorDashboard
    @current_user = current_spree_user
    @product = Spree::Product.new
    @shipping = Spree::ShippingCategory.find(1)
    @products = Spree::Product.where(spree_user_id: current_spree_user.id)
  end

  private
  def signinRouter
    if !spree_user_signed_in?
      redirect_to new_spree_user_session
    end
  end
end
