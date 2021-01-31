class AddAttributesToSpreeAddress < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_addresses, :lng, :float
    add_column :spree_addresses, :lat, :float
    add_column :spree_addresses, :instructions, :string
  end
end
