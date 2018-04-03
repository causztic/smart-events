# Location of where any lesson-session is being held.
class Location < ApplicationRecord
  has_many :sessions
  has_many :events
  validates :name, :roomname, presence: true
  scope :eventable_locations, -> { where('classroom IN (?)', [:think_tank, :lecture]) }

  def self.available_in room, start_time, end_time
    Location.find_by_sql ["SELECT * FROM locations WHERE classroom = ? AND id NOT IN
      (SELECT location_id from sessions WHERE (start_time BETWEEN ?::timestamp AND ?::timestamp)
      OR (end_time BETWEEN ?::timestamp AND ?::timestamp))",
      room, start_time, end_time - 1.second, start_time + 1.second, end_time]
  end

end