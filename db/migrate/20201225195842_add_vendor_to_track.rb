class AddVendorToTrack < ActiveRecord::Migration[6.0]
  def change
    add_reference :tracks, :spree_user, null: false, foreign_key: true
    add_column :tracks, :quantity, :integer, limit: 2
  end
end
