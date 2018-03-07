require 'rails_helper'

RSpec.describe Instructor, type: :model do
  it { should have_and_belong_to_many(:subjects) }
  it { should have_and_belong_to_many(:lessons) }
end
