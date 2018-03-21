class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  delegate :name, to: :user, prefix: :user
end
