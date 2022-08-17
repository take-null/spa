FactoryBot.define do
  factory :notification do
    books_shelf
    visitor_id { FactoryBot.create(:user).id }
    visited_id { FactoryBot.create(:user).id }
    action { Faker::Lorem.characters(number:6) }
    checked { Faker::Boolean.boolean }
    user_name { Faker::Name.first_name }
    user_image { Faker::Internet.domain_name(domain: "example") }
  end
end
