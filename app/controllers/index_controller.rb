class IndexController < ApplicationController
  def index
    if current_user
      @projects = current_user.projects
      @issues = Issue.where(project_id: current_user.projects )
      render "private"
    else
      render "public"
    end
  end
end
