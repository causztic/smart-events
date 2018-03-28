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
      start_time: s.start_time - 8.hours,
      end_time: s.end_time - 8.hours,
      title: s.subject.name,
      location: s.location.roomname,
      instructor: s.instructor.name,
      }
    }
  end

  private
  def set_chat_ids
    @chats = ChatRoom.eager_load(:users).map {|cr| { id: cr.id, name: cr.user_name }}
  end
end
