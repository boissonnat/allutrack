class IndexController < ApplicationController
  def index
    if current_user
      @projects = current_user.projects
      @issues = Issue.where(project_id: current_user.projects )

      if @projects.count > 0
        render "private"
      else
        render "private_no_project"
      end
    else
      render "public"
    end
  end
end
