class CreatePreregistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :preregistrations do |t|
      t.string :email

      t.timestamps
    end
  end
end
