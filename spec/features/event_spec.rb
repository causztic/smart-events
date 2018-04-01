require 'rails_helper'

feature 'creating an event' do
  before :all do
    @coordinator = create(:coordinator) # this creates a default user using factory_bot
    @lecture = create(:lecture)
    @event = create(:event)

    visit "login"
    within(".landing-form") do
      fill_in "Email", with: @coordinator.email
      fill_in "Password", with: "password"
    end
    click_button "Log in"
  end

  before :each do
    @event_count = Event.count
  end

  it "should be able to create a new event" do

    visit new_event_path
    fill_in "event_name", with: Faker::FamilyGuy.quote
    fill_in "event_speaker_name", with: Faker::Name.name
    fill_in "event_description", with: Faker::Lorem.paragraph
    select "Freshmore", from: 'event_pillar'
    select @lecture.name, from: 'event_location_id'
    click_button "Create Event"
    expect(page).to have_current_path(events_path)
    expect(Event.count).to eq(@event_count+1)
  end

  it "should be able to browse the events index page" do
    visit events_path
    expect(page).to have_current_path(events_path)
  end
end