FactoryBot.define do
  factory :room do
    sequence(:id) { |n| "#{n}".to_i }
  end
end
