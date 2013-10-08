class IndexController < ApplicationController
  def index
    if current_user
      @projects = current_user.projects

      @all_issues = Issue.where(project_id: current_user.projects )
      @all_opened_issues = @all_issues.where(status: STATUS[0])
      @all_closed_issues = @all_issues.where(status: STATUS[1])

      if params[:status]
        if params[:status] == 'open'
          @issues = @all_opened_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
        else
          if params[:status] == 'close'
            @issues = @all_closed_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
          else
            @issues = @all_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
          end
        end
      else
        @issues = @all_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
      end


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
