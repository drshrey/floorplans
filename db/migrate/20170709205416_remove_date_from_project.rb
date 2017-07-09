class RemoveDateFromProject < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :date
  end
end
