require 'rails_helper'

RSpec.describe Session, type: :model do
  it { should belong_to(:subject) }
  it { should belong_to(:instructor) }
  it { should have_and_belong_to_many(:students) }

  describe "validation checks" do

    START_TIME = '2018-01-01T08:00Z'
    END_TIME = '2018-01-01T09:00Z'

    before(:all) do
      students = create_list(:student, 5)
      @session = create(:session, start_time: START_TIME, end_time: END_TIME, students: students)
    end

    let(:new_session) { build(:session, start_time: START_TIME, end_time: END_TIME, location: @session.location) }

    it "should be able to be saved even when there is a conflict but not when updated" do
      expect(new_session).to be_valid
      new_session.save
      expect(new_session).not_to be_valid
      expect(new_session.errors[:location].length).to eq(1)
    end

    it "should not allow a session to be saved in the same time if there are overlapping factors" do
      new_session.location = create(:location)
      new_session.save
      expect(new_session).to be_valid

      new_session.students = @session.students
      new_session.location = @session.location
      new_session.instructor = @session.instructor

      expect(new_session).not_to be_valid
      expect(new_session.errors[:students].length).to eq(1)
      expect(new_session.errors[:location].length).to eq(1)
      expect(new_session.errors[:instructor].length).to eq(1)
    end
  end
end
