class User < ActiveRecord::Base
  validates :username, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  has_many :projects
  has_many :issues

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = lower(:value)", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me, :login)
  end
end
