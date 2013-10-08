class Ability
  include CanCan::Ability

  def initialize(user)

    ## Rights for Projects
    can :create, Project
    can :update, Project do |project|
      project.memberships.find_by_role(1).user == user
    end
    can :read, Project do |project|
      project.users.include?(user)
    end
    can :destroy, Project do |project|
      project.memberships.find_by_role(1).user == user
    end
    can :add_contributor, Project do |project|
      project.memberships.find_by_role(1).user == user
    end
    can :remove_contributor, Project do |project|
      project.memberships.find_by_role(1).user == user
    end
    can :resend_invitation_contributor, Project do |project|
      project.memberships.find_by_role(1).user == user
    end

    ## Rights for Issues
    can :manage, Issue do |issue|
      if issue.project
        issue.project.users.include?(user)
      else
        true
      end
    end

    ## Rights for Comment
    can :create, Comment do |comment|
      #comment.project.users.include?(user)
      true
    end

    can :read, Comment

    can :update, Comment do |comment|
      comment.user == user
    end

    can :delete, Comment do |comment|
      comment.user == user
    end

    can :destroy, Comment do |comment|
      comment.user == user
    end

    ## Rights for Milestones
    can :manage, Milestone do |milestone|
      if milestone.project
        milestone.project.users.include?(user)
      else
        true
      end
    end

    ## Rights for labels
    can :manage, Label

  end
end
