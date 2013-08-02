class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.references :task
      t.references :user
      t.text :objective

      t.timestamps
    end
    add_index :objectives, :task_id
    add_index :objectives, :user_id
  end
end
