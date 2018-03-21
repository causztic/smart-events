# Subject Coordinator. Responsible for arranging modules for students and instructors.
class Coordinator < User
  has_many :chat_rooms
end
