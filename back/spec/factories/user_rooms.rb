FactoryBot.define do
  factory :user_room do
    user
    room
    sequence(:id) { |n| "#{n}".to_i }
  end
end
