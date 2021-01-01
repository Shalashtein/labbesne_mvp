class CreateSocialActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :social_activities do |t|
      t.string :name

      t.timestamps
    end
  end
end
