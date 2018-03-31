class StudentController < ApplicationController
  before_action -> { authenticate_role!(Student) }

  def dashboard; end

  def schedule
    @events = current_user.sessions.includes(:subject, :location).map {|s|
      {
      start_time: s.start_time - 8.hours,
      end_time: s.end_time - 8.hours,
      title: s.subject.name,
      location: s.location.classroom,
      instructor: s.instructor.name
      }
    }
  end

  def subjects
    @subjects = Subject.includes(:instructors).joins(:students)
                       .where("subjects_users.student_id = ?", current_user)
  end
end
