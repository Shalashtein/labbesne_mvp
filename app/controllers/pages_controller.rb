class PagesController < ApplicationController
  layout 'application', only: "store"
  before_action :signinRouter

  def store
    @preference = ProfileSpec.new
    @products = Spree::Product.where(approved: true)
  end

  def preference
    p = Spree::Product.find(params[:data][:product])
    p.product_specs.each do |product_spec|
      if !ProfileSpec.where(profiles_id: current_spree_user.profile.id, specs_id: product_spec.specs.id).first.nil?
        ps = ProfileSpec.where(profiles_id: current_spree_user.profile.id, specs_id: product_spec.specs.id).first
      else
        ps = ProfileSpec.create(profiles_id: current_spree_user.profile.id, specs_id: product_spec.specs.id, value: 0)
        ps.save!
      end
      ps.value += params[:data][:action] == "1" ? 1 : -1
      ps.save!
    end
    p.swiped = true
    p.save!
  end

  def swipepage
    @products = Spree::Product.where(test: true, gender: current_spree_user.info.gender.capitalize)
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
