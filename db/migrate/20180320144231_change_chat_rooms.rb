class ChangeChatRooms < ActiveRecord::Migration[5.1]
  def change
    remove_index :chat_rooms, [:instructor_id, :coordinator_id]
    remove_column :chat_rooms, :instructor_id
    remove_column :chat_rooms, :coordinator_id
    add_column :chat_rooms, :user_id, :bigint
  end
end
