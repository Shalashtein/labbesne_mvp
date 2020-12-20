class PagesController < ApplicationController
  def home
  end

  def vendorDashboard
    @products = Spree::Product.all
  end
end
