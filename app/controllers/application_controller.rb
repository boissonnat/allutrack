class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :writers_and_readers


  private
  def writers_and_readers
    user_signed_in? ? "private" : "public"
  end

  before_filter do
    # Check Strong parameters for each Controller
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)

    # Check strong parameter for Devise as we don't have the controller
    if devise_controller?
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
      devise_parameter_sanitizer.for(:invite) { |u| u.permit(:username, :email, :invitation_for_project) }
      devise_parameter_sanitizer.for(:accept_invitation) { |u| u.permit(:username, :email, :password, :confirmation_password, :invitation_token, :invitation_for_project) }
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

end
