class AddVendorStateToSpreeOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_orders, :vendor_state, :boolean, default: false
  end
end
