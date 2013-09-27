class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :writers_and_readers

  private
  def writers_and_readers
    user_signed_in? ? "private" : "public"
  end
end
