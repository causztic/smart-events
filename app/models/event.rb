class Event < ApplicationRecord

  validates :name, :speaker_name, :description, :start_time, :end_time, :date, :location_id, presence: true
  validate :start_time_must_be_earlier

  belongs_to :location

  enum pillar: ::STUDENT_PILLARS

  def upcoming?
    Date.today - date < 0
  end

  def start_datetime
    date + start_time.hour.hours
  end

  def end_datetime
    date + end_time.hour.hours
  end

  private
  def start_time_must_be_earlier
    errors.add(:start_time, "start time must be earlier than end time!") if start_time > end_time
  end

end
