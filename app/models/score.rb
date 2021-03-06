class Score < ApplicationRecord
  belongs_to :spree_user, class_name: 'Spree::User', foreign_key: 'spree_user_id'
  belongs_to :spree_product, class_name: 'Spree::Product', foreign_key: 'spree_product_id'
end
