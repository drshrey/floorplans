class CreateVersionedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :versioned_files do |t|
      t.text :s3_url
      t.text :filename
      t.text :thumb_image_url
      t.text :large_image_url

      t.timestamps
    end
    add_reference :versioned_files, :floorplan, index: true
  end
end
