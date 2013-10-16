class SpecificationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
    if params[:project_id]
      @specification.project = Project.find(params[:project_id])

      # Generate the markdown
      ## Add project title and project description
      @specification.body = '# '+@specification.project.title + " \n\n"
      @specification.body += @specification.project.text + "\n\n"

      ## Add all issues description
      @specification.body += "## Feature in detail \n\n"
      @specification.project.issues.sort_by{|e| e[:created_at]}.each do |issue|
          @specification.body += "### " + issue.title + " \n\n"
          @specification.body += issue.body + "\n\n"
      end

    end
  end


  def create
    if @specification.save
      flash[:notice] = 'Successfully created specification.'
      @specification.create_activity :create, owner: current_user, project_id:@specification.project.id
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
      @specification.create_activity :update, owner: current_user, project_id:@specification.project.id
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
