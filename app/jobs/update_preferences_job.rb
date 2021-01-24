class UpdatePreferencesJob < ApplicationJob
  queue_as :default

  def perform(product_id, user_id, action)
    p = Spree::Product.find(product_id)
    current_user = Spree::User.find(user_id)
    #result = "User #{current_user.id}: #{action == '1' ? "liked" : "disliked"} Product##{product_id}, updating specs...\n"
    p.product_specs.each do |product_spec|
      if !ProfileSpec.where(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id).first.nil?
        ps = ProfileSpec.where(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id).first
      else
        ps = ProfileSpec.create(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id, value: 0)
        ps.save!
      end
      ps.value += action == "1" ? 1 : -1
      #result += "User #{current_user.id}: updated #{ps.specs.name}(#{ps.specs.value}) => #{ps.value}\n"
      ps.save!
    end
    p.swiped = true
    p.save!
    #puts result
  end
end
