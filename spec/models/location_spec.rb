require "rails_helper"

RSpec.describe Location, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:roomname) }

  it { should have_many(:sessions) }

  it "should have valid fixtures" do
    location = build(:location)
    expect(location).to be_valid
  end
end
