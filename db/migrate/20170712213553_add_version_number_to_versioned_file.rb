class AddVersionNumberToVersionedFile < ActiveRecord::Migration[5.1]
  def change
    add_column :versioned_files, :version_number, :integer
  end
end
