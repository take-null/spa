require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    context 'ユーザー新規作成' do
      subject(:user) { create(:user) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email) }

      it 'uid, name, emailの値が設定済みだと成功' do
        user = build(:user)
        expect(user).to be_valid
      end

      it 'uid, name, emailの値が未設定だと失敗' do
        user = build(:user)
        user.uid = ''
        user.name = ''
        user.email = ''
        expect(user).not_to be_valid
      end

      it 'uid, emailの値がユニークでなければ失敗' do
        user = create(:user)
        user_with_duplicated_uid = build(:user)
        user_with_duplicated_uid.uid = user.uid
        user_with_duplicated_uid.email = user.email
        expect(user_with_duplicated_uid).not_to be_valid
      end
    end

    context 'Userモデル更新時' do
      # password更新時
      subject(:user) { create(:user) }

      it 'profileの文字数が140文字以下なら成功' do
        user = create(:user)
        user.profile = 'a' * 140
        expect(user).to be_valid
      end

      it 'profileの文字数が140文字を超えたら失敗' do
        user = create(:user)
        user.profile = 'a' * 141
        expect(user).not_to be_valid
      end

      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password) }
    end
  end

  describe 'アソシエーションテスト' do
    subject(:user) { create(:user) }

    it { is_expected.to have_many(:active_relationships) }
    it { is_expected.to have_many(:following) }
    it { is_expected.to have_many(:passive_relationships) }
    it { is_expected.to have_many(:followers) }
    it { is_expected.to have_many(:active_notifications) }
    it { is_expected.to have_many(:passive_notifications) }
    it { is_expected.to have_many(:chat_messages) }
    it { is_expected.to have_many(:user_rooms) }
    it { is_expected.to have_many(:rooms) }
    it { is_expected.to have_many(:books_shelves) }
    it { is_expected.to have_many(:books) }
    it { is_expected.to have_many(:goods) }
    it { is_expected.to have_many(:surveys) }
  end
end
