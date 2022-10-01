require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'バリデーションテスト' do
    context '新規投稿' do
      subject(:chat_message) { create(:chat_message) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:message) }
      it { is_expected.to validate_length_of(:message) }
    end

    it 'messageの文字数が140文字以下なら成功' do
      chat_message = create(:chat_message)
      chat_message.message = 'a' * 140
      expect(chat_message).to be_valid
    end

    it 'messageの文字数が140文字を超えたら失敗' do
      chat_message = create(:chat_message)
      chat_message.message = 'a' * 141
      expect(chat_message).not_to be_valid
    end
  end

  describe 'アソシエーションテスト' do
    subject(:chat_message) { create(:chat_message) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:room) }
  end
end
