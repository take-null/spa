FactoryBot.define do
  factory :author do
    book
    sequence(:id) { |n| "#{n}".to_i }
    name { Faker::Name.name }
    is_representative { Faker::Boolean.boolean }
  end
end
