class Lesson < ApplicationRecord
    belongs_to :subject
    has_one :location

    validates :subject, presence: true
    validates :duration, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :location, presence: true
    validates :students, presence: true

    enum location_type: [ :think_tank, :classroom, :lecture_theatre, :lab ]
end
