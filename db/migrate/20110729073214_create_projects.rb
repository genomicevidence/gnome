class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :title
      t.string :scenario
      t.timestamps
    end
    add_index :projects, :user_id
  end
end