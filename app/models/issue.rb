class Issue < ActiveRecord::Base
  # Alias for acts_as_taggable_on :tags
  acts_as_taggable

  belongs_to :project
  belongs_to :user
  has_many :comments
  belongs_to :milestone
end
