FactoryBot.define do
  factory :chat_message do
    user
    room
    message { Faker::Lorem.characters(number: 140) }
  end
end