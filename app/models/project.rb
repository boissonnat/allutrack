class Project < ActiveRecord::Base
  has_many :memberships, :dependent => :delete_all
  has_many :users, :through => :memberships
  has_many :issues
  has_many :milestones

  public
    def author
      self.memberships.find_by_role(1).user
    end

  public
    def contributors
      self.memberships.where(role: 2).collect { |m| m.user }
    end
end
