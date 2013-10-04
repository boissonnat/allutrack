class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
  end
  def create
    # Create the membership

    if @project.save
      @project.memberships.create(:user_id => current_user.id, :role => 1)
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

  # Add contributors
  def add_contributor
    if params[:user_id]
      @project.memberships.create(:user_id => params[:user_id], :role => 2)
      if @project.save
        flash[:notice] = 'Successfully added contributor.'
        redirect_to @project
      end
    else
      render 'add_contributor'
    end
  end

  ## Helper methods
  def project_params
    params.require(:project).permit(:title, :text, :user_id)
  end
end
