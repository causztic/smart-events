require "rails_helper"

feature "Signing in" do
  before :all do
    @student = create(:student) # this creates a default user using factory_bot
  end
  it "signs me in and shows the correct dashboard" do
    visit "login"
    within(".landing-form") do
      fill_in "Email", with: @student.email
      fill_in "Password", with: "password"
    end
    click_button "Log in"
    expect(page).to have_content(::NOTICE::LOG_IN_SUCCESS)
    expect(page).to have_current_path(student_dashboard_path)
  end

  it "should not allow me to access any instructors pages" do
    visit instructor_dashboard_path
    expect(page).to have_http_status(401)
  end

  it "should not allow me to access any coordinators page" do
    visit coordinator_dashboard_path
    expect(page).to have_http_status(401)
  end

  # it "should allow students to see their respective calendar", js: true do
  #   visit "login"
  #   within(".landing-form") do
  #     fill_in "Email", with: @student.email
  #     fill_in "Password", with: "password"
  #   end
  #   click_button "Log in"
  #   visit student_schedule_path
  #   click_link "Subscribe to Calendar"
  # end
end
