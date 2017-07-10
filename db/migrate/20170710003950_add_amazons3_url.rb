class AddAmazons3Url < ActiveRecord::Migration[5.1]
  def change
    add_column :floorplans, :s3_url, :string
    add_column :floorplans, :filepath, :string
  end
end
