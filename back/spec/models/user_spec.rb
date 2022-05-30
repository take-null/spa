require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  #userはhas_many tweetsなので()の中はtweetモデルの複数形がシンボルとして入る
  it { should respond_to(:tweets) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  describe "when name is too long" do
    before { @user.name = "a" * 31 }
    it { should_not be_valid }
  end
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  describe "when email format is invalid" do
    it "should be invalid" do
      address = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      address.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  describe "when password is not present" do
    before { @user.password = " " }
    it { should_not be_valid }
  end
  describe "when password is not present" do
    before do
      @user = FactoryBot.build(:user, password: " ", password_confirmation: " " )
    end
    it { should_not be_valid }
  end
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  describe "tweet associations" do
    before { @user.save }
    let!(:older_tweet) do
      FactoryBot.create(:tweet, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_tweet) do
      FactoryBot.create(:tweet, user: @user, created_at: 1.day.ago)
    end
    #生成したuser、すなわち@userは上記で生成したtweetを複数持つ
    #それらを模したものが:older_micropostとnewer_micropostである
    #@user.tweetsでtweetの配列を返す事になる為、これとeq以下で定義した配列が同一ならば順序をテストした事と同義になる
    it "should have the right tweet in right order" do
      expect(@user.tweets.to_a).to eq [newer_tweet, older_tweet]
    end
    it "should destroy associated tweets" do
      tweets = @user.tweets.to_a
      @user.destroy
      expect(tweets).not_to be_empty
      tweets.each do |tweet|
        expect(Tweet.where(id: tweet.id)).to be_empty
      end
    end
  end
end
