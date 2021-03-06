module Spree::UserDecorator
  def self.prepended(base)
    base.has_one :profile, class_name: 'Profile', foreign_key: 'spree_user_id', dependent: :destroy
    base.has_one :stock_location, class_name: 'Spree::StockLocation'
    base.has_many :scores, class_name: 'Score', foreign_key: 'spree_product_id'
  end

  Spree::User.prepend self
end
