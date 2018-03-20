class ChatRoom < ApplicationRecord
  has_one    :coordinator
  belongs_to :instructor
end
