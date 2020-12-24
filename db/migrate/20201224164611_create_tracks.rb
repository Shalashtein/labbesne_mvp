class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.references :spree_line_item, null: false, foreign_key: true
      t.boolean :vendor_recieved
      t.boolean :vendor_sent
      t.boolean :recieved

      t.timestamps
    end
  end
end
