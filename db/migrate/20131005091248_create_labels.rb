class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :color
      t.references :project, index: true

      t.timestamps
    end
  end
end
