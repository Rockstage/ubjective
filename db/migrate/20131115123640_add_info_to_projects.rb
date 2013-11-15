class AddInfoToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :vision, :text
  	add_column :projects, :status, :string
  	add_column :projects, :public, :boolean, :default => false
  end
end
