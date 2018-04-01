FactoryBot.define do
  factory :location do
    name "Default Location"
    roomname "Room Name"
    classroom "classroom"
    capacity 40
    locate "Location"
    factory :lecture do
      classroom "lecture"
      capacity 200
    end
  end
end
