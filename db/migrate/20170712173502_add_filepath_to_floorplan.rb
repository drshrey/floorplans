class AddFilepathToFloorplan < ActiveRecord::Migration[5.1]
  def change
    add_column :floorplans, :filepath, :string
  end
end
