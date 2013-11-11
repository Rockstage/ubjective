class Expertise < ActiveRecord::Base
  belongs_to :user
  belongs_to :specialty
  has_many :skills, dependent: :destroy
  attr_accessible :details, :expertise, :skills_attributes
  accepts_nested_attributes_for :skills, allow_destroy: true
end
