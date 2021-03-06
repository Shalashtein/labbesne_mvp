class UpdatePreferencesJob < ApplicationJob
  queue_as :default

  def perform(product_id, user_id, action, interaction_id)
    result = []
    p = Spree::Product.find(product_id)
    current_user = Spree::User.find(user_id)
    # grab all the product specifications and map it to a profile spec increasing the value by 1
    p.product_specs.each do |product_spec|
      if ProfileSpec.where(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id).first.nil?
        ps = ProfileSpec.create(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id, value: 0)
        ps.save!
      else
        ps = ProfileSpec.where(profiles_id: current_user.profile.id, specs_id: product_spec.specs.id).first
      end
      ps.value += action == "1" ? 1 : -1
      result << "#{ps.specs.name}:#{ps.specs.value} => #{ps.value}\n"
      ps.save!
    end
    # grab the 3 top colors in a product and map them on a profile color increasing the value by 1
    product_colors = p.product_properties.where(property_id: Spree::Property.find_by(name: "Color_1").id..Spree::Property.find_by(name: "Color_3").id)
    product_colors.each do |product_color|
      pc = ProfileColor.find_or_create_by(profile_id: current_user.profile.id, color: product_color.value)
      pc.value += 1
      result << "#{product_color.value}(#{pc.value}) added to ProfileColor of user"
      pc.save!
    end
    # increase profile swipe count by 1
    current_user.profile.swiped += 1
    result << "Increased profile swipe count to #{current_user.profile.swiped}"
    i = Interaction.find(interaction_id)
    i.swiped = true
    result << "Marked interaction as swiped"
    i.like_count += 1 if action == "1"
    i.dislike_count += 1 if action != "1"
    i.save!
    current_user.profile.save
    result.each do |rx|
      puts rx
    end
  end
end
