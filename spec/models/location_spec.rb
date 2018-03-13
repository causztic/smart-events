<<<<<<< HEAD
require 'rails_helper'
=======
require "rails_helper"
>>>>>>> origin/master

RSpec.describe Location, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:roomname) }

<<<<<<< HEAD
  it "should have valid fixtures" do
    location =  build(:location)
=======
  it { should have_many(:sessions) }

  it "should have valid fixtures" do
    location = build(:location)
>>>>>>> origin/master
    expect(location).to be_valid
  end
end
