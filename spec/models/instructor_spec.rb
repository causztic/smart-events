require 'rails_helper'

RSpec.describe Instructor, type: :model do
  it { should have_and_belong_to_many(:subjects) } # it teaches many subjects, and every subject has many instructors
  it { should have_many(:sessions) } # it teaches multiple sessions, but each session only has one person teaching
  it { should have_many(:lessons) }  # it should have a through relation to the lessons via sessions
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:designation) }
  it { should validate_presence_of(:faculty) }
  
end
