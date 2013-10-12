class SpecificationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
    if params[:project_id]
      @specification.project = Project.find(params[:project_id])

      # Generate the markdown
      @specification.body = '# '+@specification.project.title + " \n\n"
      @specification.body += @specification.project.text + "\n\n"
      @specification.body += "## Overview of features \n\n"
      @specification.body += "| Name | \n\n"
      @specification.body += "| ---------- | \n\n"

      @specification.project.issues.each do |issue|
        @specification.body += "| " + issue.title + " |\n\n"
      end
      @specification.body += "## Feature in detail \n\n"
      @specification.project.issues.each do |issue|
          @specification.body += "### " + issue.title + " \n\n"
          @specification.body += issue.body + "\n\n"
      end

    end
  end


  def create
    if @specification.save
      flash[:notice] = 'Successfully created specification.'
      redirect_to @specification.project
    else
      render 'new'
    end

  end

  # Read
  def show
  end

  # Edit
  def edit
  end

  def update
    if @specification.update_attributes(params[:specification])
      flash[:notice] = 'Successfully updated specification.'
      redirect_to @specification.project
    else
      render 'edit'
    end
  end

  # Delete
  def destroy
    project = @specification.project
    @specification.destroy
    flash[:notice] = 'Successfully destroyed specification.'
    redirect_to project
  end

  ## Helper methods
  def specification_params
    params.require(:specification).permit(:title, :body, :project_id)
  end
end
