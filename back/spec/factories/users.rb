FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    image { Faker::Internet.domain_name(domain: "example") }
    profile { Faker::String.random }
    age { Faker::Number.between(from: 1, to: 120) }
    locate {Faker::String.random(length: [0, 6]) }
    email { Faker::Internet.email }
    password { "samplepassword" }
    password_confirmation { "samplepassword" }
  end
end
