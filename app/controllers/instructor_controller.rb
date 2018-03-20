class InstructorController < ApplicationController
  before_action -> { authenticate_role!(Instructor) }
  before_action :get_chat_room

  def dashboard; end
  def preferences; end

  def subjects
    @subjects = current_user.subjects
  end

  private
  def get_chat_room
    @chat = ChatRoom.find_or_create_by(user: current_user)
  end

end
