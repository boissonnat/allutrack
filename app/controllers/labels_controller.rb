class LabelsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  ## Create
  def new
    if params[:project_id]
      @label.project = Project.find(params[:project_id])
    end
  end
  def create
    if @label.save
      flash[:notice] = 'Successfully created label.'
      redirect_to @label.project
    else
      render 'new'
    end
  end

  ## Edit
  def edit
  end
  def update
    @project = @label.project
    if @label.update_attributes(params[:label])
      flash[:notice] = 'Successfully updated label.'
      redirect_to @project
    else
      render 'edit'
    end
  end

  # Delete
  def destroy
    @project = @label.project
    @label.destroy
    flash[:notice] = 'Successfully destroyed label.'
    redirect_to @project
  end

  ## Helper methods
  def label_params
    params.require(:label).permit(:title, :color, :project_id)
  end

end
