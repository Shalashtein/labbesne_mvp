class PagesController < ApplicationController
  layout 'application', only: "store"
  before_action :signinRouter
  before_action :setCart

  def store
    @preference = ProfileSpec.new
    @products_sorted = Spree::Product.where(approved: true).order(swiped: :desc, id: :desc).page(params[:page])
    @item = Spree::LineItem.new
  end

  def preference
    UpdatePreferencesJob.perform_later(params[:data][:product], current_spree_user.id, params[:data][:action])
  end

  def swipepage
    @products = Spree::Product.where(test: true, gender: current_spree_user.profile.info.gender.capitalize)
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

  private
  def signinRouter
    if !spree_user_signed_in?
      redirect_to spree.login_path
    end
  end

  def setCart
    @order = current_spree_user.last_incomplete_spree_order || Spree::Order.new
  end
end
