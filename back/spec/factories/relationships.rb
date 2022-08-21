FactoryBot.define do
  factory :relationship do
    sequence(:id) { |n| "#{n}".to_i }
    follower_id    { FactoryBot.create(:user).id }
    followed_id    { FactoryBot.create(:user).id }
  end
end
