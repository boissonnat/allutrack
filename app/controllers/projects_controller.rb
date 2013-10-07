class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Create
  def new
  end
  def create
    # Add some default labels to every new project
    story = Label.new(title: 'story', color: '#428bca')
    ready_for_review = Label.new(title: 'ready for review', color: '#5cb85c')
    bug = Label.new(title: 'bug', color: '#d9534f')
    feature = Label.new(title: 'feature', color: '#5bc0de')
    question = Label.new(title: 'question', color: '#f0ad4e')
    ui = Label.new(title: 'ui', color: '#cc317c')

    @project.labels << [story, ready_for_review, bug, feature, ui, question]

    if @project.save
      # Create the membership
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
