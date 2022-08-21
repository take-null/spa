FactoryBot.define do
  factory :user do
    sequence(:id) { |n| "#{n}" }
    name { Faker::Name.name }
    sequence(:uid) { |n| "sample#{n}@sample.com"}
    sequence(:email) { |n| "sample#{n}@sample.com" }
    sequence(:password) { |n| "samplepassword#{n}" }
    sequence(:password_confirmation) { |n| "samplepassword#{n}" }
    profile { Faker::Lorem.characters(number: 140) }
  end
end
