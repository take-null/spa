FactoryBot.define do
  factory :book do
    sequence(:id) { |n| "#{n}".to_i }
    google_books_api_id { 'jfApAQAAMAAJ' }
    title { Faker::Book.title }
    image { Faker::Internet.url }
    publisher { Faker::Book.publisher }
    published_at { Faker::Date.forward(days: 23) }
  end
end
