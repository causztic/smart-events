require 'rails_helper'

feature "Signing in" do
  before :each do
    @user = create(:user) # this creates a default user using factory_bot
  end

  it "signs me in" do
    login_as(@user, scope: :user)
  end

end