require 'rails_helper'

RSpec.describe BooksShelf, type: :model do
  describe 'アソシエーションテスト' do
    subject(:books_shelf) { create(:books_shelf) }
    
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
    it { is_expected.to have_many(:notifications) }
  end
end
