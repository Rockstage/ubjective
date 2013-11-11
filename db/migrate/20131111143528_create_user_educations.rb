class CreateUserEducations < ActiveRecord::Migration
  def change
    create_table :user_educations do |t|
      t.references :user
      t.string :institution
      t.string :edu_level
      t.string :edu_field
      t.date :edu_date

      t.timestamps
    end
    add_index :user_educations, :user_id
  end
end
