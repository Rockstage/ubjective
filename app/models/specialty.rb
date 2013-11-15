class Specialty < ActiveRecord::Base

  searchkick autocomplete: ['specialty']

  belongs_to :user
  has_many :expertises, dependent: :destroy
  has_many :skills
  attr_accessible :role, :specialty, :expertises_attributes
  accepts_nested_attributes_for :expertises, allow_destroy: true
end
