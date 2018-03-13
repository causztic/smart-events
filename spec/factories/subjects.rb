FactoryBot.define do
  factory :subject do

    code "1"
    name "1"
    description { Faker::Simpsons.quote }
    hours_per_week 10_000
    facility_hours "Classroom":3
    minimum_hours_per_lesson 5
    term_available 1
    factory :subject_with_invalid_hours do
    end

    # code "2"
    # name "2"
    # description { Faker::Simpsons.quote }
    # hours_per_week 10
    # facility_hours "Think_Tank":2
    # term_available 2
    # factory :subject_with_invalid_hours do
    # end

  end
end
