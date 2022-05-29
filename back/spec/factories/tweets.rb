FactoryBot.define do
  factory :tweet do
    tweet_content { "hello_world" }
    #userへの関連付けを行う際は以下の様に記述する
    association :user
  end
end
