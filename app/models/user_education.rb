class UserEducation < ActiveRecord::Base
  belongs_to :user
  attr_accessible :edu_date, :edu_field, :edu_level, :institution
end
