class Event < ApplicationRecord

  validate :start_time_must_be_earlier

  def start_time_must_be_earlier
    errors.add(:start_time, "start time must be earlier than end time!") if start_time > end_time
  end

end
