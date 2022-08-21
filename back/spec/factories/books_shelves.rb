FactoryBot.define do
  factory :books_shelf do
    user
    book
    #sequence(:id) { |n| "#{n}".to_i }
    comment { Faker::Lorem.characters(number:400) }
    google_books_api_id { Faker::Internet.password(min_length: 12, max_length: 12) }
    rating { 5 }
  end
end
