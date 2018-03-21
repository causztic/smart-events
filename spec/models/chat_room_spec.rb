require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:users) }
  it { should have_many(:messages) }
end
