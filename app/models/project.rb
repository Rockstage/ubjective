class Project < ActiveRecord::Base
  belongs_to :user
  attr_accessible :category, :description, :location, :mission, :title, :vision, :status, :public

  validates :title, presence: true, length: { minimum: 2, maximum: 240 }
  validates :mission, presence: true
  validates :category, presence: true


  scope :public, where(:public => true)
  scope :private, where(:public => false)
end
