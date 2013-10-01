class IndexController < ApplicationController
  def index
    if current_user
      @projects = current_user.projects
      @issues = current_user.issues
      render "private"
    else
      render "public"
    end
  end
end
