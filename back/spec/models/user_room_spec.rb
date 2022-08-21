require 'rails_helper'

RSpec.describe UserRoom, type: :model do
  
  describe "アソシエーションテスト" do
    subject(:user_room) { create(:user_room) }
    
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:room) }
  end
end