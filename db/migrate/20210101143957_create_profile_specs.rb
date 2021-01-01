class CreateProfileSpecs < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_specs do |t|
      t.references :profiles, null: false, foreign_key: true
      t.references :specs, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
