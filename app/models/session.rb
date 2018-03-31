# Session for lessons.
class Session < ApplicationRecord
  has_many :sessions_users, dependent: :destroy
  has_many :students, through: :sessions_users
  belongs_to :instructor
  belongs_to :subject
  belongs_to :location
  enum day: Date::DAYNAMES

  validate :check_conflicts, on: :update

  def check_conflicts
    # checks for student conflicts, instructor conflicts, and location conflicts.
    sql = "SELECT s.location_id, s.instructor_id, array_agg(u.student_id) students FROM sessions s
      INNER JOIN sessions_users u ON s.id = u.session_id
      WHERE s.id IN
      (SELECT id FROM sessions WHERE (start_time BETWEEN '#{start_time}'::timestamp AND '#{end_time - 1.second}'::timestamp
        OR end_time BETWEEN '#{start_time + 1.second}'::timestamp AND '#{end_time}'::timestamp)
      AND id != '#{id}')
      GROUP BY(s.id);"
    results = ActiveRecord::Base.connection.execute(sql)
    results.each do |conflict|
      # check if there are any conflicts
      student_conflict = (students.pluck(:id) & conflict['students'].slice(1, conflict['students'].length - 2).split(',').map(&:to_i)).present?
      errors.add(:students, "Cannot have the same student taking more than one class at the same time!") if student_conflict

      # check for instructor conflicts
      instructor_conflict = instructor.id == conflict['instructor_id']
      errors.add(:instructor, "Cannot have the same instructor teaching more than one class at the same time!") if instructor_conflict

      # check for location conflicts
      location_conflict = location.id == conflict['location_id']
      errors.add(:location, "Cannot use the same location for multiple ongoing classes!") if location_conflict
    end
  end

end
