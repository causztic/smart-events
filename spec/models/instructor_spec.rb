require 'rails_helper'

RSpec.describe Instructor, type: :model do
  it { should have_and_belong_to_many(:subjects) }
  it { should have_and_belong_to_many(:lessons) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:designation) }
  it { should validate_presence_of(:faculty) }
end
