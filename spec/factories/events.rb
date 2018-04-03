FactoryBot.define do
  factory :event do
    name "Event"
    description "Description"
    speaker_name "Speaker Name"
    date 20180315
    start_time '19:00'
    end_time '20:00'
    pillar 0
    location
  end
end
