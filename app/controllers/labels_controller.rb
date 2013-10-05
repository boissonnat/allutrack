class LabelsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
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

  ## Helper methods
  def label_params
    params.require(:label).permit(:title, :color, :project_id)
  end

end
