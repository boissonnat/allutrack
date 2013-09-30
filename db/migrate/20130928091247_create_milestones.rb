class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :title
      t.date :dueTo
      t.references :project, index: true

      t.timestamps
    end
  end
end
