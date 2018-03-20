class CreateChatRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_rooms do |t|
      t.string :title
      t.bigint :instructor_id
      t.bigint :coordinator_id
      t.timestamps
    end

    add_index :chat_rooms, [:instructor_id, :coordinator_id]
  end
end
