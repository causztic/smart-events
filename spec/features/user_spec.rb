require 'rails_helper'

feature "Signing in" do
  before :each do
    @user = create(:student) # this creates a default user using factory_bot
  end

end