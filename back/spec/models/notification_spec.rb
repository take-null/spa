require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { FactoryBot.create(:notification) }

  describe '通知機能' do
    context '保存できる場合' do
      it '全てのパラメーターが揃っていれば保存できる' do
        expect(notification).to be_valid
      end
    end

    context '保存できない場合' do
      it 'visitor_idがnilの場合は保存できない' do
        notification.visitor_id = nil
        expect(notification).not_to be_valid
      end

      it 'visited_idがnilの場合は保存できない' do
        notification.visited_id = nil
        expect(notification).not_to be_valid
      end
    end
  end

  context 'Books_shelfモデルとの関係' do
    it 'N:1となっている' do
      expect(Notification.reflect_on_association(:books_shelf).macro).to eq :belongs_to
    end
  end

  describe 'Userモデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context '仮想モデルvisitorとのアソシエーション' do
      let(:target) { :visitor }

      it 'Followerとの関連付けはbelongs_toであること' do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context '仮想モデルvisitedとのアソシエーション' do
      let(:target) { :visited }

      it 'Followedとの関連付けはbelongs_toであること' do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end
end
