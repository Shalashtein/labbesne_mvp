class CreateLifestyles < ActiveRecord::Migration[6.0]
  def change
    create_table :lifestyles do |t|
      t.references :profiles, null: false, foreign_key: true
      t.references :activity_levels, null: true, foreign_key: true
      t.boolean :works
      t.references :job_types, null: true, foreign_key: true
      t.integer :work_hours, limit: 2
      t.boolean :studies
      t.integer :study_hours, limit: 2
      t.references :social_activities, null: true, foreign_key: true
      t.references :outdoor_levels, null: true, foreign_key: true

      t.timestamps
    end
  end
end
