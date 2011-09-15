class CreateGenomes < ActiveRecord::Migration
  def change
    create_table :genomes do |t|
      t.integer :dataset_id
      t.string :file_name
      t.string :genome_build
      t.string :ancestry
      t.integer :variants_count, :default => 0
      t.timestamps
    end
    add_index :genomes, :dataset_id
  end
end