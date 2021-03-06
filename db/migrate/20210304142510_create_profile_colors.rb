class CreateProfileColors < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_colors do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :color
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
