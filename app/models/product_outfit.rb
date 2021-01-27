class ProductOutfit < ApplicationRecord
  belongs_to :spree_product, class_name: 'Spree::Product'
  belongs_to :outfit, class_name: 'Outfit'
end
