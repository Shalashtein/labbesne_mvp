class CreateActivityLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_levels do |t|
      t.string :name

      t.timestamps
    end
  end
end
