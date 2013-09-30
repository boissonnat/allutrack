class MilestonesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
    @projects = Project.all
  end
  def create
    if @milestone.save
      flash[:notice] = 'Successfully created milestone.'
      redirect_to @milestone
    else
      render 'new'
    end

  end

  # Read
  def show
    @milestone = Milestone.find(params[:id])
    @issues = @milestone.issues
  end

  # Edit
  def edit
    @projects = Project.all
  end

  def update
    @projects = Project.all
    if @milestone.update_attributes(params[:milestone])
      flash[:notice] = 'Successfully updated milestone.'
      redirect_to @milestone
    else
      render 'edit'
    end
  end

  # Delete
  def destroy
    @milestone.destroy
    flash[:notice] = 'Successfully destroyed milestone.'
    redirect_to milestones_path
  end

  # List
  def index
    @milestones = Milestone.all
  end

  ## Helper methods
  def milestone_params
    params.require(:milestone).permit(:title, :dueTo, :project_id)
  end
end

