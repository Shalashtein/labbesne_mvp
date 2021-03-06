class AddScoreStateToSpreeUser < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_users, :score_state, :string, default: 'listening'
  end
end
