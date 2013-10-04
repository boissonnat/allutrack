class AddRoleMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :role, :integer, default: 1
  end
end
