<<<<<<< HEAD
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:subjects) }
  it { should validate_presence_of(:email) }
=======
require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }

  describe "factory tests" do
    let(:student) { build(:student) }
    let(:instructor) { build(:instructor) }
    let(:coordinator) { build(:coordinator) }

    it "should all be valid" do
      expect(student).to be_valid
      expect(instructor).to be_valid
      expect(coordinator).to be_valid
    end
  end
>>>>>>> origin/master
end
