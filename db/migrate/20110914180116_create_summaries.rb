class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.integer :genome_id
      t.string :category
      t.string :subcategory
      t.string :item
      t.integer :variants_count
    end
    add_index :summaries, :genome_id
  end
end