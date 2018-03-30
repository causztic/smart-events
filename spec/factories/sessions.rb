FactoryBot.define do
  factory :session do
    location
    instructor
    subject

    factory :session_with_students do
      transient do
        students_count 5
      end

      after(:create) do |session, evaluator|
        create_list(:student, evaluator.students_count, sessions: [session])
      end
    end
  end
end
