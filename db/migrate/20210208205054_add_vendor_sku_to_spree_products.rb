class AddVendorSkuToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :vendorSKU, :string
  end
end
