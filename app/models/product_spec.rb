class ProductSpec < ApplicationRecord
  belongs_to :spree_product, class_name: 'Spree::Product'
  belongs_to :specs
end
