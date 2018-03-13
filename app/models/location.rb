# Location of where any lesson-session is being held.
class Location < ApplicationRecord
  has_and_belong_to_many :sessions
  validates :name, :roomname, :capacity, :type, presence: true
end
