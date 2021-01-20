class AddTestToSpreeProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :test, :boolean
  end
end
