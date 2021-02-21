class CreateProductProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :product_properties do |t|
      t.references :spree_product_properties, null: false, foreign_key: true
      t.references :spree_users, null: false, foreign_key: true
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
