class AddApprovedToSpreeProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :approved, :boolean, default: false
  end
end
