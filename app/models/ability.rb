class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Project
    can :update, Project do |project|
      project.memberships.find_by_role(1).user
    end
    can :read, Project do |project|
      project.memberships.find_by_role(1).user
    end
    can :destroy, Project do |project|
      project.memberships.find_by_role(1).user
    end
    can :add_contributor, Project do |project|
      project.memberships.find_by_role(1).user
    end

    can :manage, Issue

    can :manage, Comment

    can :manage, Milestone
  end
end
