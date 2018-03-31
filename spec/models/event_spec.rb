require 'rails_helper'

RSpec.describe Event, type: :model do

    describe "time validations" do
        it "should not allow start time to be later than end_time" do
            event = build(:event)
            event.start_time = Time.now
            event.end_time = Time.now - 1.hour
            expect(event).to_not be_valid
        end
    end
end