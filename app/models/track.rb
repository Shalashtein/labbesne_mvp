class Track < ApplicationRecord
  belongs_to :item, class_name: "Spree::LineItem", foreign_key: "spree_line_item_id"
  belongs_to :order, class_name: "Spree::Order", foreign_key: "spree_order_id"
end
