class CreateGeneSets < ActiveRecord::Migration
  def change
    create_table :gene_sets do |t|
      t.integer :collection_id
      t.string :name
      t.integer :genes_count, :default => 0
      t.string :url
      t.text :gene_ids
    end
    add_index :gene_sets, :collection_id
  end
end