# A lesson. Has multiple Sessions for multiple classes.
class Lesson < ApplicationRecord
  belongs_to :subject
  belongs_to :location
  has_many :sessions

  validates :subject, :duration, :location, presence: true

  enum location_type: ::LOCATION_TYPES
end
