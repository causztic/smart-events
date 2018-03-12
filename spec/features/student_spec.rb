require 'rails_helper'

feature "Signing in" do
  before :each do
    @student = create(:student) # this creates a default user using factory_bot
  end
  it "signs me in and shows the correct dashboard" do
    visit 'login'
    within('#session') do
      fill_in 'Email', with: @student.email
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content(::NOTICE.LOG_IN_SUCCESS)
    expect(page).to have_current_path(student_dashboard_path)
  end
end