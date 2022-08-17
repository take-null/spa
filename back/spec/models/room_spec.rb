require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'アソシエーションテスト' do
    subject(:room) { create(:room) }
    
    it { is_expected.to have_many(:chat_messages) }
    it { is_expected.to have_many(:user_rooms) }
    it { is_expected.to have_many(:users) }
  end 
end
