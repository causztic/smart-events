class Lesson < ApplicationRecord
  belongs_to :subject
  belongs_to :location
  has_many :sessions

  validates :subject, :duration, :start_time, :end_time, :location, presence: true

  enum location_type: ::LOCATION_TYPES
end
