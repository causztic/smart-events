# Location of where any lesson-session is being held.
class Location < ApplicationRecord
  has_many :sessions
  validates :name, :roomname, :start_time, :end_time, presence: true
end
