class AddThumbLarge < ActiveRecord::Migration[5.1]
  def change
    add_column :floorplans, :thumb, :string
    add_column :floorplans, :large, :string
  end
end
