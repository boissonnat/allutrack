class Users::InvitationsController < Devise::InvitationsController
  def update
      super
  end

  def invitation_params
    params.require(:invitation).permit(:invite, :accept_invitation, :password, :password_confirmation, :username)
  end

end