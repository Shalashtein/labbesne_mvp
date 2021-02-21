class UpdateScoresJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    products = Spree::Product.where()
    # By Color Preferences Spree::ProductProperty.where(property_id: 16).where('value IN (?)', ["12130e"])
  end
end
