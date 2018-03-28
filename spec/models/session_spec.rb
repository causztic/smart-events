require 'rails_helper'

RSpec.describe Session, type: :model do
  it { should belong_to(:subject) }
  it { should belong_to(:instructor) }
  it { should have_and_belong_to_many(:students) }
end
