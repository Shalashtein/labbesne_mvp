class CreateBodyMeasurements < ActiveRecord::Migration[6.0]
  def change
    create_table :body_measurements do |t|
      t.references :profiles, null: false, foreign_key: true
      t.references :body_types, null: false, foreign_key: true
      t.integer :height, limit: 2
      t.integer :weight, limit: 2
      t.string :shirt_size
      t.float :pants_size
      t.float :shoe_size

      t.timestamps
    end
  end
end
