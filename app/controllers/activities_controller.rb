class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where(project_id: current_user.projects).order('created_at desc')
  end
end
