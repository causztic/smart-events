class Event < ApplicationRecord

  validates :name, :speaker_name, :description, :start_time, :end_time, :date, presence: true
  validate :start_time_must_be_earlier

  enum pillar: ::STUDENT_PILLARS

  def upcoming?
    Date.today - date < 0
  end

  private
  def start_time_must_be_earlier
    errors.add(:start_time, "start time must be earlier than end time!") if start_time > end_time
  end

end
