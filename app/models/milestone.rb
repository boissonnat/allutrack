class Milestone < ActiveRecord::Base
  validates :title, presence: true
  validate :due_to_cannot_be_in_the_past

  # Specific validation method : Due date cannot be in the past
  def due_to_cannot_be_in_the_past
    if dueTo.present? && dueTo < Date.today
      errors.add(:dueTo, "can't be in the past")
    end
  end

  belongs_to :project
  has_many :issues



end
