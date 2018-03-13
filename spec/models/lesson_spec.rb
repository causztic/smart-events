require "rails_helper"

RSpec.describe Lesson, type: :model do
  it { should belong_to(:subject) }
  it { should belong_to(:location)}

  it{ should validate_presence_of(:subject, :duration, :start_time, :end_time, :location)}

  describe "it should have multiple sessions to accomodate for student size" do
    it { should have_many(:sessions) }
  end
end
