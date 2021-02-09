class AddOrderIdToTrack < ActiveRecord::Migration[6.1]
  def change
    add_reference :tracks, :spree_order, null: true, foreign_key: true
  end
end
