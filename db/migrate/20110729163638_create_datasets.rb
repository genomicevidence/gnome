class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.integer :project_id
      t.string :category
      t.string :file
      t.integer :genomes_count, :default => 0
      t.timestamps
    end
    add_index :datasets, :project_id
  end
end