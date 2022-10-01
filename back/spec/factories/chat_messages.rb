FactoryBot.define do
  factory :chat_message do
    user
    room
    sequence(:id) { |n| "#{n}".to_i }
    message { Faker::Lorem.characters(number: 140) }
  end
end
