class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
  end
  def create
    @project.user = current_user
    if @project.save
      flash[:notice] = 'Successfully created project.'
      redirect_to @project
    else
      render 'new'
    end

  end

  # Read
  def show
    @project = Project.find(params[:id])
    @issues = @project.issues
    @milestones = @project.milestones
  end

  # Edit
  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = 'Successfully updated project.'
      redirect_to @project
    else
      render 'edit'
    end
  end

  # Delete
  def destroy
    @project.destroy
    flash[:notice] = 'Successfully destroyed project.'
    redirect_to projects_path
  end

  # List
  def index
    @projects = current_user.projects
  end

  ## Helper methods
  def project_params
    params.require(:project).permit(:title, :text)
  end
end
