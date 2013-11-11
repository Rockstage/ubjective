class CreateUserLanguages < ActiveRecord::Migration
  def change
    create_table :user_languages do |t|
      t.references :user
      t.string :language
      t.string :skill_level

      t.timestamps
    end
    add_index :user_languages, :user_id
  end
end
