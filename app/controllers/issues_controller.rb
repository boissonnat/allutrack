class IssuesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
    @projects = Project.all
  end
  def create
    @issue.user = current_user
    @issue.status = STATUS[0]
    if @issue.save
      flash[:notice] = 'Successfully created issue.'
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
    @issue.destroy
    flash[:notice] = 'Successfully destroyed issue.'
    redirect_to issues_path
  end

  # List
  def index
    @issues = current_user.issues
  end

  def tagged
    if params[:tag].present?
      @issues = Issue.tagged_with(params[:tag])
    else
      @issues = Issue.all
    end
  end

  def close

    @issue.status = STATUS[1]
    if @issue.save
      flash[:notice] = 'Successfully closed issue.'
      redirect_to @issue
    end
  end

  ## Helper methods
  def issue_params
    params.require(:issue).permit(:title, :body, :project_id, :milestone_id, :tag_list)
  end
end

