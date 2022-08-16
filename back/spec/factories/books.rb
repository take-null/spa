FactoryBot.define do
  factory :book do
    google_books_api_id { Faker::Lorem.characters(number:12) }
    title { Faker::Book.title }
    image { Faker::Internet.url }
    publisher { Faker::Book.publisher }
    published_at { Faker::Date.forward(days: 23) }
  end
end
