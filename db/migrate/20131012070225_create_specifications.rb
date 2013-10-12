class CreateSpecifications < ActiveRecord::Migration
  def change
    create_table :specifications do |t|
      t.string :title
      t.references :project, index: true

      t.timestamps
    end
  end
end
