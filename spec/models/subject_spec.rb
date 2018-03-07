require 'rails_helper'

RSpec.describe Subject, type: :model do
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

  describe "base subject" do
    let(:subject) { build(:subject) }
    it "should be valid" do
      expect(subject).to be_valid
    end
  end

  describe "invalid subjects" do
    let(:subject) { build(:subject_with_invalid_hours) }
    it "should not have excessive hours per week" do
      expect(subject).to_not be_valid
    end
  end
end
