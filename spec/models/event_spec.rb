require "rails_helper"

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:speaker_name) }

  it { should belong_to(:location) }

  describe "time validations" do
    it "should not allow start time to be later than end_time" do
      event = build(:event)
      event.start_time = Time.now
      event.end_time = Time.now - 1.hour
      expect(event).to be_invalid
    end

    it "should be able to be created even if there is an existing session on the same timeslot" do
        event = build(:event)
        expect(event).to be_valid
        session = create(:session)
        event.start_time = session.start_time
        event.end_time = session.end_time
        expect(event).to be_valid
    end
  end
end
