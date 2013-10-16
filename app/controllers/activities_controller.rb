class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where(project_id: current_user.projects).paginate(:page => params[:page], :per_page => 50).order('created_at desc')
  end
end
