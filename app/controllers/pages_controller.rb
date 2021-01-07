class PagesController < ApplicationController
  before_action :signinRouter

  def home
  end

  def profileRouter
    @measurements_progress = if !current_spree_user.profile.body_measurement.nil?
                              100
                             else
                              0
                             end
  end

  private
  def signinRouter
    if !spree_user_signed_in?
      redirect_to spree.login_path
    end
  end
end
