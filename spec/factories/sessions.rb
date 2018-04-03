FactoryBot.define do
  factory :session do
    location
    instructor
    subject
    start_time { Time.now }
    end_time { Time.now + 1.hour }

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
