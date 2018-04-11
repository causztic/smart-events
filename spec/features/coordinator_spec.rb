require "rails_helper"

feature "Signing in" do
  before :each do
    @coordinator = create(:coordinator) # this creates a default user using factory_bot
  end
  it "signs me in and shows the correct dashboard" do
    visit "login"
    within(".landing-form") do
      fill_in "Email", with: @coordinator.email
      fill_in "Password", with: "password"
    end
    click_button "Log in"
    expect(page).to have_content(::NOTICE::LOG_IN_SUCCESS)
    expect(page).to have_current_path(coordinator_schedules_path)
  end

  it "should not allow me to access any instructors pages" do
    visit instructor_dashboard_path
    expect(page).to have_http_status(401)
  end

  it "should not allow me to access any students page" do
    visit student_dashboard_path
    expect(page).to have_http_status(401)
  end
end
