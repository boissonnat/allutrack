class Comment < ActiveRecord::Base
  include PublicActivity::Common
  #tracked owner: Proc.new{ |controller, model| controller.current_user }

  validates :body, presence: true

  belongs_to :issue
  belongs_to :user
end
