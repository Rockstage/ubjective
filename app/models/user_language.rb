class UserLanguage < ActiveRecord::Base
  belongs_to :user
  attr_accessible :language, :skill_level
end
