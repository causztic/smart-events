FactoryBot.define do
  factory :subject do
    code "1"
    name "1"
    description { Faker::Simpsons.quote }
    hours_per_week 9
    facility_hours 10
    minimum_hours_per_lesson 5
    term_available 1
    factory :subject_with_invalid_hours do
      hours_per_week 10_000
    end
  end
end
