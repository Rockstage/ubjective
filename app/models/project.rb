class Project < ActiveRecord::Base
  belongs_to :user
  attr_accessible :category, :description, :location, :mission, :title

  validates :title, presence: true, length: { minimum: 2, maximum: 240 }
end
