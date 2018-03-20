class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room-#{message.chat_room_id}:messages", message: message
  end
end