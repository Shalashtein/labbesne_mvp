class CreateProductOutfits < ActiveRecord::Migration[6.1]
  def change
    create_table :product_outfits do |t|
      t.references :spree_product, null: false, foreign_key: true
      t.references :outfit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
