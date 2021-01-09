class AddParentToSpecs < ActiveRecord::Migration[6.0]
  def change
    add_column :specs, :parent, :integer
  end
end
