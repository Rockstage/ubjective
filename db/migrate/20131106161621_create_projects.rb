class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :user
      t.string :title
      t.text :mission
      t.text :description
      t.string :location
      t.string :category

      t.timestamps
    end
    add_index :projects, :user_id
  end
end
