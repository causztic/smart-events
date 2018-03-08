require 'rails_helper'

RSpec.describe Event, type: :model do
    {end_time>=start_time}.should be_true
    validates :end_time, presence: true, time: {after_or_equal_to: :start_time}
    validates :end_date, presence: true, date: {after_or_equal_to: :start_date}
    validates :name, presence: true
    validates :speaker_name, presence: true
    validates :duration, numericality => { :greater_than_or_equal_to => 0, :less_than_or_Equal_to => 600}
    validates :date, date.valid_date?
    validates :pillar, 
end
