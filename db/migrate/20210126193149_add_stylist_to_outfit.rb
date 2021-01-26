class AddStylistToOutfit < ActiveRecord::Migration[6.1]
  def change
    add_reference :outfits, :spree_user, null: false, foreign_key: true
  end
end
