FactoryBot.define do
  factory :survey do
    user
    sequence(:id) { |n| "#{n}".to_i }
    title { Faker::Lorem.characters(number: 140) }
    content { Faker::Lorem.characters(number: 140) }
  end
end
