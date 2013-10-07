class AddLabelsToIssues < ActiveRecord::Migration
  def change
    create_table :issues_labels, :id => false do |t|
      t.references :issue, :null => false
      t.references :label, :null => false
    end
    add_index :issues_labels, [:issue_id, :label_id]
  end
end
