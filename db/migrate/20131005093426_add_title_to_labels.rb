class AddTitleToLabels < ActiveRecord::Migration
  def change
    add_column :labels, :title, :string
  end
end
