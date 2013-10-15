class AddProjectToActivity < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.integer :project_id
    end
  end
end
