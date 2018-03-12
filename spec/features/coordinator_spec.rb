require 'rails_helper'

feature "Signing in" do
  before :each do
    @coordinator = create(:coordinator) # this creates a default user using factory_bot
  end
  it "signs me in and shows the correct dashboard" do
    visit 'login'
    within('.landing-form') do
      fill_in 'Email', with: @coordinator.email
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content(::NOTICE::LOG_IN_SUCCESS)
    expect(page).to have_current_path(coordinator_dashboard_path)
  end
end