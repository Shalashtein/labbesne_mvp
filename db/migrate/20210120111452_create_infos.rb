class CreateInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :infos do |t|
      t.belongs_to :profiles, null: false, foreign_key: true
      t.string :name
      t.date :dob
      t.string :gender
      t.string :phone

      t.timestamps
    end
  end
end
