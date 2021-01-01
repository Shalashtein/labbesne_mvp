class CreateOutdoorLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :outdoor_levels do |t|
      t.string :level

      t.timestamps
    end
  end
end
