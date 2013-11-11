class Skill < ActiveRecord::Base
  belongs_to :user
  belongs_to :specialty
  belongs_to :expertise
  attr_accessible :description, :skill, :skill_lvl
end
