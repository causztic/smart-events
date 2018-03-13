require "rails_helper"

feature "Session check" do
  before :each do
    @instructor = create(:instructor) # this creates a default user using factory_bot
  end
  it "should redirect me back to the login screen with an invalid email" do
    visit "login"
    within(".landing-form") do
      fill_in "Email", with: "non-existent@email.com"
      fill_in "Password", with: "password"
    end
    click_button "Log in"
    expect(page).to have_content(::NOTICE::LOG_IN_FAILURE)
    expect(page).to have_current_path(login_path)
  end
end
