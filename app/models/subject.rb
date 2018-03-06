class Subject < ApplicationRecord
    self.primary_key = :code
    has_many :lessons, dependent: :destroy

    validates :code, presence: true
    validates :name, presence: true
    validates :description, presence: true
    validates :hours_per_week, presence: true
    validates :facility_hours, presence: true
    validates :minimum_hours_per_lesson, presence: true
    validates :term_available, presence: true

    enum pillar: [ :Freshmore, :EPD, :ESD, :ISTD, :ASD, :Everyone ]
    # enum pillar: [ 0: freshmore, 1: epd, 2: esd, 3: istd, 4: asd, 5: unspecified ]
end
