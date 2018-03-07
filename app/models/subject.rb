class Subject < ApplicationRecord
    has_many :lessons, dependent: :destroy

    validates :code, :name, :description, :hours_per_week, :facility_hours, :minimum_hours_per_lesson, :term_available, presence: true
    validates :hours_per_week, numericality: { less_than: 10 }
    validate :hours_per_week_must_be_bigger

    enum pillar: ::PILLARS

    has_and_belongs_to_many :students
    has_and_belongs_to_many :instructors

    def hours_per_week_must_be_bigger
        if hours_per_week.present? && minimum_hours_per_lesson.present?
            if hours_per_week < minimum_hours_per_lesson
                errors.add(:hours_per_week, "too small!")
            end
        end
    end
end
