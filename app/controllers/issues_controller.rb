class IssuesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
    @projects = Project.all
    if params[:project_id]
      @issue.project = Project.find(params[:project_id])
    end
    if params[:milestone_id]
      @issue.milestone = Milestone.find(params[:milestone_id])
    end
  end
  def create
    @issue.user = current_user
    @issue.status = STATUS[0]
    if @issue.save
      flash[:notice] = 'Successfully created issue.'
      @issue.create_activity :create, owner: current_user, project_id:@issue.project.id
      redirect_to @issue
    else
      render 'new'
    end

  end

  # Read
  def show
    @issue = Issue.find(params[:id])
  end

  # Edit
  def edit
    @projects = Project.all
  end

  def update
    @projects = Project.all
    if @issue.update_attributes(params[:issue])
      flash[:notice] = 'Successfully updated issue.'
      redirect_to @issue
    else
      render 'edit'
    end
  end

  # Delete
  def destroy
    @project = @issue.project
    @issue.destroy
    flash[:notice] = 'Successfully destroyed issue.'
    redirect_to project_path(@project)
  end

  # List
  def index
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
  end

  def close
    @issue.status = STATUS[1]
    if @issue.save
      flash[:notice] = 'Successfully closed issue.'
      @issue.create_activity :close, owner: current_user, project_id:@issue.project.id
      redirect_to @issue
    end
  end

  def reopen
    @issue.status = STATUS[0]
    if @issue.save
      flash[:notice] = 'Successfully closed issue.'
      @issue.create_activity :reopen, owner: current_user, project_id:@issue.project.id
      redirect_to @issue
    end
  end

  ## Helper methods
  def issue_params
    params.require(:issue).permit(:title, :body, :project_id, :milestone_id, :label_ids => [])
  end
end

