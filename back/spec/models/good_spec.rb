require 'rails_helper'

RSpec.describe Good, type: :model do
  
  describe "アソシエーションテスト" do
    subject(:good) { create(:good) }
    
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:books_shelf) }
  end
end
