class Objective < ActiveRecord::Base
  acts_as_list
  belongs_to :task
  belongs_to :user
  attr_accessible :objective, :completed, :updated_at

  validates :objective, presence: true, length: { minimum: 2, maximum: 500 }

  scope :completed, where(:completed => true)
  scope :incompleted, where(:completed => false)
  # Allows us to do @task.objectives.incompleted.each do
  
end
