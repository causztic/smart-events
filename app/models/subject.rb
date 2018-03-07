class Subject < ApplicationRecord
    has_many :lessons, dependent: :destroy

    validates :code, :name, :description, :hours_per_week, :facility_hours, :minimum_hours_per_lesson, :term_available, presence: true
    enum pillar: [ :Freshmore, :EPD, :ESD, :ISTD, :ASD, :PillarYear ]

    has_and_belongs_to_many :users
end
