class AddPersonalInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :datetime
    add_column :users, :gender, :string
    add_column :users, :location, :string
    add_column :users, :contact, :string
    add_column :users, :personal_goal, :text
    add_column :users, :pro_goal, :text
    add_column :users, :interests, :text
  end
end
