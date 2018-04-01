# Location of where any lesson-session is being held.
class Location < ApplicationRecord
  has_many :sessions
  has_many :events
  validates :name, :roomname, presence: true
  scope :eventable_locations, -> { where('classroom IN (?)', [:think_tank, :lecture]) }
end
