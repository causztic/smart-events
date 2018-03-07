class Lesson < ApplicationRecord
    belongs_to :subject
    belongs_to :location
    has_many :sessions
    
    validates :subject, :duration, :start_time, :end_time, :location, presence: true

    enum location_type: [ :think_tank, :classroom, :lecture_theatre, :lab ]

end
