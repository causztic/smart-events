# Subject has many lessons, and is taught by multiple instructors.
class Subject < ApplicationRecord
  has_many :lessons, dependent: :destroy

  validates :code, :name, :hours_per_week, :facility_hours, :minimum_hours_per_lesson, :term_available, presence: true
  validates :hours_per_week, numericality: { less_than: 10 }
  validate :hours_per_week_must_be_bigger
  validate :facility_hours_should_have_arrays
  validates :term_available, numericality: { greater_than: 0, less_than: 9}

  enum pillar: ::PILLARS

  has_and_belongs_to_many :students
  has_and_belongs_to_many :instructors

  def full_name
    "#{code} - #{name}"
  end

  def self.subjects_this_term(pillar, term = 0)
    where(pillar: pillar, term_available: term).order("RANDOM()").limit(3)
  end

  def self.freshmore_hass(term = 0)
    where(pillar: :FreshmoreHASS, term_available: term).order("RANDOM()").limit(1)
  end

  # convenience method for random_sample with HASS
  def self.random_hass
    where(pillar: :HASS).order("RANDOM()").limit(1)
  end

  def self.with_students
    joins(:students).where("student_id IS NOT NULL").distinct
  end

  # validations
  def hours_per_week_must_be_bigger
    return if hours_per_week.blank? && minimum_hours_per_lesson.blank?
    errors.add(:hours_per_week, "too small!") if hours_per_week < minimum_hours_per_lesson
  end

  def facility_hours_should_have_arrays
    facility_hours.each_value do |value|
      return errors.add(:facility_hours, "invalid hours! must be an array") unless value.is_a? Array
    end if facility_hours.present?
  end

  # to use code as the params
  def to_param
    code
  end
end
