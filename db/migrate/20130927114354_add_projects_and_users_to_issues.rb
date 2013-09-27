class AddProjectsAndUsersToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :user, index: true
    add_reference :issues, :project, index: true
  end
end
