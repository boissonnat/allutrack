class Users::InvitationsController < Devise::InvitationsController
  def update
      super
      # publish activity
      project = Project.find(current_inviter.invitation_for_project)
      if project
        project.create_activity :join, owner: current_user, project_id:project.id
      end

  end

  def invitation_params
    params.require(:invitation).permit(:invite, :accept_invitation, :password, :password_confirmation, :username)
  end

end