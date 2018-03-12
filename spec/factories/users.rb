FactoryBot.define do
  factory :user do
    email { Faker::Internet.email } 
    password 'password'
    password_confirmation 'password'
    
    factory :student do
      type Student
    end

    factory :instructor do
      type Instructor
    end

    factory :coordinator do
      type Coordinator
    end

  end
end
