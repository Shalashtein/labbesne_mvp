module Spree::ProductDecorator

  def self.prepended(base)
    base.has_many :product_specs, class_name: 'ProductSpec', foreign_key: 'spree_product_id'
    base.has_many :product_outfits, class_name: 'ProductOutfit', foreign_key: 'spree_product_id'
  end

Spree::Product.prepend self
end
