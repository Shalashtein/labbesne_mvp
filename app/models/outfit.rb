class Outfit < ApplicationRecord
  has_many :spree_products, class_name: 'Spree::Product'
  has_one :spree_user, class_name: 'Spree::User'
end
