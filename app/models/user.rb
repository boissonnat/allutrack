class User < ActiveRecord::Base
  validates :username, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  after_invitation_accepted :email_invited_by

  def email_invited_by
    project = Project.find(self.invitation_for_project)
    if project
      project.memberships.create(user_id: id, role: 2)
    end
  end

  has_many :memberships, :dependent => :delete_all
  has_many :projects, :through => :memberships
  has_many :issues

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = lower(:value)", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
