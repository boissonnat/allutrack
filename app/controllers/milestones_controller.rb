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

    @all_issues = @milestone.issues
    @all_opened_issues = @all_issues.where(status: STATUS[0])
    @all_closed_issues = @all_issues.where(status: STATUS[1])

    if @milestone.issues.count > 0
      @progress = (@all_closed_issues.count * 100) / @milestone.issues.count
    else
      @progress = 0
    end

    if params[:status]
      if params[:status] == 'open'
        @issues = @all_opened_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
      else
        if params[:status] == 'close'
          @issues = @all_closed_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
        else
          if params[:status] == 'all'
            @issues = @all_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
          else
            @issues = @all_opened_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
          end
        end
      end
    else
      @issues = @all_opened_issues.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    end

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

