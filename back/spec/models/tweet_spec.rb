require 'rails_helper'
RSpec.describe Tweet, type: :model do
  #解説
  #FactoryBot.create(:user)で事前に定義していたユーザーオブジェクトを生成する
  #letメソッドでuserという変数を作る。これは{}の中のメソッドの結果が代入されている
  #user.tweets.buldで"hello"と書かれたマイクロポストのオブジェクトを作成し@tweet変数に代入
  #subjectは{}の中のオブジェクトについてテストするという合図
  #it { should respond_to(:???) }はシンボルのオブジェクトが存在するか検証する
  #it { expect(subject.user).to eq user }は検証する@tweetについて
  #.userでユーザーオブジェクトを生成し、これがFactoryBotで生成されたユーザーオブジェクト
  #と同一であるかを検証している
  #should be_valid, should be_invalidは妥当か、そうじゃないかを検証している
  #before { @tweet.user_id = nil }で検証用のカラムを一旦nilにしてこれが妥当で無いという事を検証している

  let(:user) { FactoryBot.create(:user) }
  before { @tweet = user.tweets.build(tweet_content: "hello") }

  subject { @tweet }

  it { should respond_to(:tweet_content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }  
  it { expect(subject.user).to eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @tweet.user_id = nil }
    it { should be_invalid }
  end
end