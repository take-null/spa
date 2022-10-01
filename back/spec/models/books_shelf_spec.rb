require 'rails_helper'

RSpec.describe BooksShelf, type: :model do
  describe 'バリデーションテスト' do
    context '新規投稿' do
      subject(:books_shelf) { create(:books_shelf) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:rating) }
      it { is_expected.to validate_presence_of(:comment) }
      it { is_expected.to validate_length_of(:comment) }
      it { is_expected.to validate_presence_of(:google_books_api_id) }
    end

    it 'rating, comment, google_books_api_idの値が設定済みだと成功' do
      books_shelf = build(:books_shelf)
      expect(books_shelf).to be_valid
    end

    it 'rating, comment, google_books_api_idの値が未設定だと失敗' do
      books_shelf = build(:books_shelf)
      books_shelf.rating = ''
      books_shelf.comment = ''
      books_shelf.google_books_api_id = ''
      expect(books_shelf).not_to be_valid
    end

    it 'commentの文字数が400文字以下なら成功' do
      books_shelf = create(:books_shelf)
      books_shelf.comment = 'a' * 400
      expect(books_shelf).to be_valid
    end

    it 'commentの文字数が400文字を超えたら失敗' do
      books_shelf = create(:books_shelf)
      books_shelf.comment = 'a' * 401
      expect(books_shelf).not_to be_valid
    end
  end

  describe 'アソシエーションテスト' do
    subject(:books_shelf) { create(:books_shelf) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
    it { is_expected.to have_many(:notifications) }
  end
end
