class AddMilestoneToSpreeUser < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_users, :milestone, :boolean, default: false
  end
end
