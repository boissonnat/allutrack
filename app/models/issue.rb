class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :comments
  belongs_to :milestone
  has_and_belongs_to_many :labels
end
