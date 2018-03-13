# Location of where any lesson-session is being held.
class Location < ApplicationRecord
  has_many :sessions
  validates :name, :roomname, :capacity, :type, presence: true
end
