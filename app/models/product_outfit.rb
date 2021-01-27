class ProductOutfit < ApplicationRecord
  belongs_to :spree_product
  belongs_to :outfit
end
