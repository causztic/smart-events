FactoryBot.define do
  factory :event do
    name "Event"
    description "Description"
    speaker_name "Speaker Name"
    date 20180315
    start_time { Time.now }
    end_time { Time.now + 1.hour }
    pillar 0
    location
  end
end
