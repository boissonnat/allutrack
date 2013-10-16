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
    wont_fix = Label.new(title: 'wont fix', color: '#000000')
    @project.labels << [story, ready_for_review, bug, feature, ui, question, wont_fix]

    # Add default milestone
    no_milestone = Milestone.new(title: 'No milestone')
    @project.milestones << no_milestone

    if @project.save
      # Create the membership
      @project.memberships.create(:user_id => current_user.id, :role => 1)
      flash[:notice] = 'Successfully created project.'
      @project.create_activity :create, owner: current_user, project_id:@project.id
      redirect_to @project
    else
      render 'new'
    end

  end

  # Read
  def show
    @project = Project.find(params[:id])
    @milestones = @project.milestones

    @all_issues = @project.issues
    @all_opened_issues = @all_issues.where(status: STATUS[0])
    @all_closed_issues = @all_issues.where(status: STATUS[1])

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
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = 'Successfully updated project.'
      @project.create_activity :update, owner: current_user, project_id:@project.id
      redirect_to @project
    else
      render 'edit'
    end
  end

  # Delete
  def destroy
    @project.destroy
    flash[:notice] = 'Successfully destroyed project.'
    redirect_to root_path
  end

  # List
  def index
    @projects = current_user.projects
  end

  # Add contributors
  def add_contributor
    if params[:emails]
      number_of_contributors = 0
      number_of_invitations = 0
      # Trim and split emails by ';' into array
      emails_as_array = params[:emails].gsub(/\s+/, "").split(";")
      emails_as_array.each do |email|
        contributor = User.find_by_email(email)

        if contributor
          # We have find the user in DB
          if (contributor.invitation_sent_at && contributor.invitation_accepted_at) || contributor.invitation_sent_at.nil?
            # We add the user as contributor only if he has no invitation or if the full invitation process has been done
            @project.memberships.create(user_id: contributor.id, role: 2)
            number_of_contributors = number_of_contributors + 1
            # Add join activity on project
            @project.create_activity :join, owner: contributor, project_id:@project.id
          end

        else
          # No user found, send him an invitation
          User.invite!(:email => email, invitation_for_project: @project.id)
          number_of_invitations = number_of_invitations + 1
        end
      end

      if @project.save
        flash[:notice] =
            number_of_contributors.to_s + ' contributor(s) added to the project. ' +
            number_of_invitations.to_s + ' invitation(s) sent.'
        redirect_to @project
      end
    else
      render 'add_contributor'
    end
  end

  def resend_invitation_contributor
    if params[:user_email]
      User.invite!(email: params[:user_email], invitation_for_project: @project.id)
      flash[:notice] = 'Invitation resent successfully'
    end
    redirect_to @project
  end

  def remove_contributor
    if params[:user_id]
      contributor = User.find(params[:user_id])
      memberships = Membership.where(project_id: @project.id, user_id: params[:user_id])
      memberships.each do |membership|
        membership.destroy
      end
      # Add left activity on project
      @project.create_activity :left, owner: contributor, project_id:@project.id
    end
    redirect_to @project
  end

  ## Helper methods
  def project_params
    params.require(:project).permit(:title, :text, :emails)
  end
end
