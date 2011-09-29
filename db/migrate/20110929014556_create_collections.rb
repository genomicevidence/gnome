class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.string :description
      t.string :url
      t.integer :gene_sets_count, :default => 0
    end
  end
end