class Track < ApplicationRecord
  belongs_to :item, class_name: "Spree::LineItem", foreign_key: "spree_line_item_id"
end
