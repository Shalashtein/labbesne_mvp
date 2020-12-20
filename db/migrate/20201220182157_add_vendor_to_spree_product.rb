class AddVendorToSpreeProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :vendor, :string
  end
end
