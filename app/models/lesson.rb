class Lesson < ApplicationRecord
    belongs_to :subject
    has_one :location
    has_many :instructors
    has_many :students
    
    validates :subject, :duration, :start_time, :end_time, :location, :students, presence: true

    enum location_type: [ :think_tank, :classroom, :lecture_theatre, :lab ]

end
