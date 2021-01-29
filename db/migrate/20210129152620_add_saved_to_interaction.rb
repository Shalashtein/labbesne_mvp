class AddSavedToInteraction < ActiveRecord::Migration[6.1]
  def change
    add_column :interactions, :saved, :boolean, default: false
  end
end
