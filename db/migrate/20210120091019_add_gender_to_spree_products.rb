class AddGenderToSpreeProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :gender, :string
  end
end
