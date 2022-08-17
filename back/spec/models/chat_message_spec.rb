require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'アソシエーションテスト' do
    subject(:chat_message) { create(:chat_message) }
    
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:room) }
  end
end