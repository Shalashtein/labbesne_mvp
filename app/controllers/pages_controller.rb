class PagesController < ApplicationController
  layout 'application', only: "store"
  before_action :signinRouter

  def store
    @products = Spree::Product.where(approved: true)
  end

  def swipepage
    @products = Spree::Product.all
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
end
