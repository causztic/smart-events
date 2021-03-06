class StudentController < ApplicationController
  before_action -> { authenticate_role!(Student) }

  def dashboard; end

  def schedule
    @events = current_user.sessions.includes(:subject, :location).map {|s|
      {
        id: s.id,
        start_time: s.start_time - 8.hours,
        end_time: s.end_time - 8.hours,
        title: s.subject.name,
        location: { name: s.location.name, id: s.location.id, room: s.location.classroom },
        instructor: { name: s.instructor.name, id: s.instructor.id},
        type: 'session'
      }
    }.concat all_events
  end

  def subjects
    @subjects = Subject.includes(:instructors).joins(:students)
                       .where("subjects_users.student_id = ?", current_user)
  end
end
