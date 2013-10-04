class ChangeRelationUsersProjects < ActiveRecord::Migration
  def change
    add_reference :memberships, :project, index: true
    add_reference :memberships, :user, index: true
  end
end
