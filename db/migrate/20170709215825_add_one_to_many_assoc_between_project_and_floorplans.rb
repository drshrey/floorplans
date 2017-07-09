class AddOneToManyAssocBetweenProjectAndFloorplans < ActiveRecord::Migration[5.1]
  def change
    add_reference :floorplans, :project, index: true
  end
end
