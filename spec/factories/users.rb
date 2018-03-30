FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"

    factory :student, parent: :user, class: 'Student' do
    end

    factory :instructor, parent: :user, class: 'Instructor' do
      name { Faker::Name.name }
      designation { Faker::Job.title }
      faculty "faculty"
    end

    factory :coordinator, parent: :user, class: 'Coordinator' do
    end
  end
end
