FactoryBot.define do
  factory :chat_messages do
    message { Faker::String.random(length: 1..140)}
  end
end