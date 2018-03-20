require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  it { should belong_to(:instructor) }
  it { should have_one(:coordinator) }
end
