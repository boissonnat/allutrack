class Comment < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :issue
  belongs_to :user
end
