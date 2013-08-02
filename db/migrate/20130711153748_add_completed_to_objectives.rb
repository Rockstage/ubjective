class AddCompletedToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :completed, :boolean, :default => false
  end
end
