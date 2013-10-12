class AddBodySpecifications < ActiveRecord::Migration
  def change
    add_column :specifications, :body, :text
  end
end
