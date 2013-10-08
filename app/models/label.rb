class Label < ActiveRecord::Base
  validates :title, presence: true
  validates :color, presence: true

  belongs_to :project
  has_and_belongs_to_many :issues
end
