FactoryBot.define do
  factory :event do
    events_model 1.5
    name "Event"
    description "Description"
    speaker_name "Speaker Name"
    duration 40.0
    date 20180315
    pillar "Pillar"
  end
end
