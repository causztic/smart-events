class InstructorController < ApplicationController

  before_action -> { authenticate_role!(Instructor) }
  before_action :get_chat_room

  def dashboard; end
  def preferences; end

  def schedule
    @events = current_user.sessions.includes(:subject).map {|s|
      {
      start_time: s.start_time - 8.hours,
      end_time: s.end_time - 8.hours,
      subject: s.subject.name
      }
    }
  end

  def subjects
    @subjects = current_user.subjects
  end

  def update_preferences
    current_user.preferences = params[:_json]
    current_user.save
  end

  private
  def get_chat_room
    @chats = [ChatRoom.find_or_create_by(user: current_user)]
  end

end
