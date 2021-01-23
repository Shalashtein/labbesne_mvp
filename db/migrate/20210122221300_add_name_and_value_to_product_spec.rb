class AddNameAndValueToProductSpec < ActiveRecord::Migration[6.0]
  def change
    add_column :product_specs, :name, :string
    add_column :product_specs, :value, :string
  end
end
