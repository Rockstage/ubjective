class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :authentications
  has_many :projects
  has_many :tasks
  has_many :objectives
  has_many :user_languages
  has_many :user_educations
  has_many :specialties, dependent: :destroy
  has_many :expertises
  has_many :skills

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name, :role, :current_password,
                  :birthday, :gender, :location, :contact, :personal_goal, :pro_goal, :interests,
                  :user_languages_attributes, :user_educations_attributes,
                  :specialties_attributes
                  
  accepts_nested_attributes_for :user_languages, allow_destroy: true
  accepts_nested_attributes_for :user_educations, allow_destroy: true
  accepts_nested_attributes_for :specialties, allow_destroy: true

  after_destroy :cleanauth

  validates :email, presence: true, uniqueness: true

  validates :profile_name, presence: true, 
              uniqueness: true, 
              format: {
              with: /\A[a-zA-Z0-9_-]+\z/,
              message: "Must be formatted correctly using: a-z, A-Z, 0-9, - and _ "
            }

  validates :birthday, presence: true

  # accepts_nested_attributes_for :model
  # also add to attr_accessible :model_attributes
  
  # Instead of having objectives through tasks, we would access objectives by tasks.objectives

  def full_name
    first_name + " " + last_name
  end

  def to_param
    profile_name
  end

  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'],
    :uid => omni['uid'],
    :token => omni['credentials'].token,
    :token_secret => omni['credentials'].secret)
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super #&& provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end



  def facebook
    access_token = self.authentications.find_by_provider('facebook').token
    @facebook ||= Koala::Facebook::API.new(access_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end

  def share_task_to_facebook
    facebook { |fb| fb.put_wall_post("testing") }
  end

  private
  def cleanauth
    self.authentications.destroy_all
    self.tasks.destroy_all
  end

end
