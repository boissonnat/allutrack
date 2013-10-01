class MilestonesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
    @projects = Project.all
    if params[:project_id]
      @milestone.project = Project.find(params[:project_id])
    end
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
    @closed_issues = Issue.where(status: STATUS[1], milestone_id: @milestone.id)
    @progress = (@closed_issues.count * 100) / @issues.count
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

