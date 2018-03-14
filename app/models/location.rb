# Location of where any lesson-session is being held.
class Location < ApplicationRecord
  has_and_belongs_to_many :sessions
  validates :name, :roomname, :capacity, :location_type, presence: true
end
