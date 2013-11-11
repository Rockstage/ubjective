class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :user
      t.references :specialty
      t.references :expertise
      t.string :skill
      t.integer :skill_lvl
      t.text :description

      t.timestamps
    end
    add_index :skills, :user_id
    add_index :skills, :specialty_id
    add_index :skills, :expertise_id
  end
end
