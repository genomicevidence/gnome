class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.integer :project_id
      t.string :category
      t.string :file

      t.timestamps
    end
    add_index :datasets, :project_id
  end
end