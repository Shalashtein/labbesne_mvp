class UpdateScoresJob < ApplicationJob
  queue_as :default
  include Colorscore

  def perform(user_id)
    user = Spree::User.find(user_id)
    # grab the unswiped products or all approved products if all have been swiped
    products = Spree::Product.includes(:interactions).where(approved: true,
                                                            interactions: { swiped: false,
                                                                            spree_user_id: user.id })
    products = Spree::Product.where(approved: true) if products.count == 0

    # Grab max profile spec value to use in normalization
    max = user.profile.profile_specs.maximum(:value)

    # Grab All the Profile Specs of the user with their values
    user.profile.profile_specs.each do |profile_spec|
      # Normalize the values between 0 and 100
      normalized_value = profile_spec.value.to_f / max * 100
      spec_id = profile_spec.specs.id
      products.joins(:product_specs).joins(:specs).where(specs: { id: spec_id }).group(:id).each do |product|
        score = Score.find_or_create_by(spree_user_id: user.id, spree_product_id: product.id)
        score.value = 0 if score.value.nil?
        score.value += normalized_value
        score.save!
      end
    end
    Score.all.order(value: :desc).each do |score|
      puts "#{Spree::Product.find(score.spree_product_id).name} ==> #{score.value}"
    end
  end
  # By Color Preferences Spree::ProductProperty.where(property_id: 16).where('value IN (?)', ["12130e"])
end
