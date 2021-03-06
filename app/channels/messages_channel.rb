# app/channels/messages_channel.rb
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room-#{params['room']}:messages"
  end

  def receive(payload)
    Message.create(user: current_user, chat_room_id: params["room"], content: payload["message"])
  end
end