class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.date :date
      t.text :title

      t.timestamps
    end
  end
end
