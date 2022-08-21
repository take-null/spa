require 'rails_helper'

RSpec.describe Book, type: :model do
  
  describe 'アソシエーションテスト' do
    subject(:book) { create(:book) }
    
    it { is_expected.to have_many(:authors) }
    it { is_expected.to have_many(:books_shelves) }
    it { is_expected.to have_many(:users) }
  end
end
