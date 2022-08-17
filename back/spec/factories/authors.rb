FactoryBot.define do
  factory :author do
    book
    name { Faker::Name.name }
    is_representative { Faker::Boolean.boolean }
  end
end
