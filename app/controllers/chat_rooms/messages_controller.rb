class ChatRooms::MessagesController < ChatRoomsController
  def index
    @messages = Message.where(chat_room_id: params[:chat_room_id])
  end
end