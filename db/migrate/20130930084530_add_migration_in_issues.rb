class AddMigrationInIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :milestone, index: true
  end
end
