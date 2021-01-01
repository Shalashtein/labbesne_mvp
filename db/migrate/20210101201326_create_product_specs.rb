class CreateProductSpecs < ActiveRecord::Migration[6.0]
  def change
    create_table :product_specs do |t|
      t.references :spree_product, null: false, foreign_key: true
      t.references :specs, null: false, foreign_key: true

      t.timestamps
    end
  end
end
