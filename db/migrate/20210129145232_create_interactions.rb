class CreateInteractions < ActiveRecord::Migration[6.1]
  def change
    create_table :interactions do |t|
      t.references :spree_product, null: false, foreign_key: true
      t.references :spree_user, null: false, foreign_key: true
      t.boolean :expanded, default: false
      t.boolean :swiped, default: false
      t.integer :like_count
      t.integer :dislike_count
      t.boolean :bought, default: false

      t.timestamps
    end
  end
end
