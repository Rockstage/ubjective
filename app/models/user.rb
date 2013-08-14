class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :authentications
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name, :role, :current_password

  after_destroy :cleanauth

  validates :email, presence: true, uniqueness: true

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
    @facebook ||= Koala::Facebook::API.new(:token)
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
