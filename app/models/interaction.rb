class Interaction < ApplicationRecord
  belongs_to :spree_product, class_name: 'Spree::Product'
  belongs_to :spree_user, class_name: 'Spree::User'
end
