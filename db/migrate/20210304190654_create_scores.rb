class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :spree_user, null: false, foreign_key: true
      t.references :spree_product, null: false, foreign_key: true
      t.float :value, default: 0

      t.timestamps
    end
  end
end
