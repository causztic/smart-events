class Instructor::ChatRoomsController < InstructorController

  def start
    @chat_room = current_user.chat_room
    unless @chat_room.present?
      @chat_room = Coordinator.first.chat_rooms.build(instructor: current_user)
      @chat_room.save
    end
  end

end