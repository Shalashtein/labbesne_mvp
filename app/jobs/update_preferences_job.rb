class UpdatePreferencesJob < ApplicationJob
  queue_as :default

  def perform(user_id, product_id)
    p = Spree::Product.find(product_id)
    current_user = Spree::User.find(user_id)
    p.product_specs.each do |product_spec|
      if !ProfileSpec.where(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id).first.nil?
        ps = ProfileSpec.where(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id).first
      else
        ps = ProfileSpec.create(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id, value: 0)
        ps.save!
      end
      ps.value += params[:data][:action] == "1" ? 1 : -1
      ps.save!
    end
    p.swiped = true
    p.save!
  end
end
