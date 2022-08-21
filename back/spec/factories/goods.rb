FactoryBot.define do
  factory :good do
    user
    books_shelf
    sequence(:id) { |n| "#{n}".to_i }
  end
end
