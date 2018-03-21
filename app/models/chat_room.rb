class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :users, through: :messages
  has_many :messages, dependent: :destroy
end
