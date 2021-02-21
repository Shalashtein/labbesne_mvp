class ProductProperty < ApplicationRecord
  belongs_to :property, class_name: 'Spree::ProductProperty', foreign_key: 'spree_product_properties_id'
  belongs_to :user, class_name: 'Spree::User', foreign_key: 'spree_users_id'
end
