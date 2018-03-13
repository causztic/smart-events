require "rails_helper"

RSpec.describe Lesson, type: :model do
  it { should belong_to(:subject) }

  describe "it should have multiple sessions to accomodate for student size" do
    it { should have_many(:sessions) }
  end
end
