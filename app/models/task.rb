class Task < ActiveRecord::Base
  belongs_to :user
  has_many :objectives
  attr_accessible :description, :title, :updated_at
  after_destroy :cleanup


  validates :title, presence: true, length: { minimum: 2, maximum: 120 }

  # objective.public / private
  scope :public, where(:public => true)
  scope :private, where(:public => false)

  private

  # Deletes Objectives associated with a Task, when the parent task is deleted
  def cleanup
    self.objectives.destroy_all
  end

end
