FactoryBot.define do
  factory :student do
    email { Faker::Internet.email } 
    password 'password'
    type Student
    password_confirmation 'password'
  end
end
