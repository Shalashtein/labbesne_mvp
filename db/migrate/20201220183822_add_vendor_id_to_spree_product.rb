class AddVendorIdToSpreeProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :spree_products, :vendor, :string
    add_reference :spree_products, :spree_user, null: true, foreign_key: true
  end
end
