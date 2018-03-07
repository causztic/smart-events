class Subject < ApplicationRecord
    self.primary_key = :code
    has_many :lessons, dependent: :destroy

    validates :code, :name, :description, :hours_per_week, :facility_hours, :minimum_hours_per_lesson, :term_available, presence: true
    enum pillar: [ :Freshmore, :EPD, :ESD, :ISTD, :ASD, :PillarYear ]
end
