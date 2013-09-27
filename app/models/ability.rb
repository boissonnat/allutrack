class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Project
    can :update, Project do |project|
      project.user
    end
    can :read, Project do |project|
      project.user
    end
    can :destroy, Project do |project|
      project.user
    end
  end
end
