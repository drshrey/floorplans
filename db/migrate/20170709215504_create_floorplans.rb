class CreateFloorplans < ActiveRecord::Migration[5.1]
  def change
    create_table :floorplans do |t|
      t.text :display_name
      t.text :blueprint

      t.timestamps
    end
  end
end
