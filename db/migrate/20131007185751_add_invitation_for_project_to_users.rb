class AddInvitationForProjectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invitation_for_project, :string
  end
end
