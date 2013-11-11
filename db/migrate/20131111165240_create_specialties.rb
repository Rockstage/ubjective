class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.references :user
      t.string :specialty
      t.string :role

      t.timestamps
    end
    add_index :specialties, :user_id
  end
end
