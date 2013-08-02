class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name, :role

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :profile_name, presence: true, 
              uniqueness: true, 
              format: {
              with: /\A[a-zA-Z0-9_-]+\z/,
              message: 'Must be formatted correctly.'
            }

  has_many :tasks
  has_many :objectives
  # Instead of having objectives through tasks, we would access objectives by tasks.objectives

  def full_name
    first_name + " " + last_name
  end

  def to_param
    profile_name
  end
  



end
