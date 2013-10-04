class RemoveDirectRelationUsersProjects < ActiveRecord::Migration
  def change
    remove_reference :projects, :user, index: true
  end
end
