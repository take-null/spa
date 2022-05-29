FactoryBot.define do
  factory :user do
    #{}についての解説
    #現在のFactoryBotでは検証用に生成するデータは{}の中に書かなければならない
    #sequenceの解説
    #sequence(:name) { |n| "sample#{n}" }と記述すると
    #nの値がその都度更新され、"sample1","sample2"...と増えて行く為、テストデータの一意性が保たれる
    sequence(:name) { |n| "sample#{n}" }
    sequence(:email) { |n| "sample#{n}@example.com" }
    password { "samplepassword" }
    password_confirmation { "samplepassword" }
  end
end
