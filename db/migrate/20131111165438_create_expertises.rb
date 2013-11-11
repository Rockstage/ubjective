class CreateExpertises < ActiveRecord::Migration
  def change
    create_table :expertises do |t|
      t.references :user
      t.references :specialty
      t.string :expertise
      t.text :details

      t.timestamps
    end
    add_index :expertises, :user_id
    add_index :expertises, :specialty_id
  end
end
