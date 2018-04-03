class CoordinatorController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }
  before_action :set_chat_ids

  def dashboard
    @unassigned_subjects = Subject.find_by_sql("select * from subjects s
      left outer join subjects_users su on s.id = su.subject_id
      where su.student_id IS NULL AND su.instructor_id IS NULL;").count
  end

  def schedules
    @events = Session.all.includes(:subject, :location, :instructor).map {|s|
      {
      id: s.id,
      start_time: s.start_time - 8.hours,
      end_time: s.end_time - 8.hours,
      title: s.subject.name,
      location: { name: s.location.roomname, id: s.location.id },
      instructor: { name: s.instructor.name, id: s.instructor.id},
      group: s.session_group,
      type: 'session'
      }
    }.concat all_events
    @cohorts = SessionsUser.connection.execute(
      'SELECT DISTINCT array_agg(session_id) FROM sessions_users GROUP BY student_id;').values
      .map { |v| v[0][1..v[0].length-2].split(',').map &:to_i }
  end

  private
  def set_chat_ids
    @chats = ChatRoom.eager_load(:users).map {|cr| { id: cr.id, name: cr.user_name }}
  end
end
