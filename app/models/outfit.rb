class Outfit < ApplicationRecord
  has_many :product_outfits, class_name: 'ProductOutfit', foreign_key: 'outfit_id'
  has_one :spree_user, class_name: 'Spree::User'
end
