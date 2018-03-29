# Session for lessons.
class Session < ApplicationRecord
  has_and_belongs_to_many :students
  belongs_to :instructor
  belongs_to :subject
  belongs_to :location
  enum day: Date::DAYNAMES

  before_update :check_student_conflicts, :check_location_conflicts, :check_instructor_conflicts

  private
  def check_student_conflicts
  end

  def check_location_conflicts
  end

  def check_instructor_conflicts
  end

end
