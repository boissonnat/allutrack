class Specification < ActiveRecord::Base
  include PublicActivity::Common
  validates :title, presence: true

  belongs_to :project
end
