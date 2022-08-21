require 'rails_helper'

RSpec.describe GoogleBook, type: :model do

  let(:google_book) { FactoryBot.build(:google_book) }
  describe 'Apiの機能' do
    context "有効な場合" do
      it "必要なパラメーターが揃っていれば有効" do
        expect(google_book).to be_valid
      end
    end
  
    context "無効な場合" do
      it 'Google Books APIのIDが存在しないときに無効なこと' do
        google_book.google_books_api_id = nil
        expect(google_book).to_not be_valid
      end
  
      it 'タイトルが存在しないときに無効なこと' do
        google_book.title = nil
        expect(google_book).to_not be_valid
      end
    end
  end
  
  it 'google_books_api_idからインスタンスを生成できること' do
    google_books_api_id = 'jfApAQAAMAAJ'
    google_book = GoogleBook.new_from_id(google_books_api_id)
    expect(google_book.title).to eq 'ハリー・ポッターと賢者の石'
    expect(google_book.google_books_api_id).to eq google_books_api_id
    expect(google_book.authors).to eq ["J.K. ローリング"]
  end
  
  it '適切なキーワードから複数の検索結果を返し、そのタイトルにキーワードが含まれていること' do
    keyword = 'Ruby'
    keyword_count = 0
    google_books = GoogleBook.search(keyword)
    expect(google_books.size).to be >= 5 
    google_books.each do |google_book|
      if google_book.title.include?(keyword)
        keyword_count += 1
      end
    end
    expect(keyword_count).to be >= 5
  end
  
  describe '保存時に' do
    context '不適切な情報しか持たないときは' do
      let(:google_book) { build(:google_book, google_books_api_id: nil) }
      it '保存に失敗すること' do
        expect { google_book.save }.to change { Book.count }.by(0).and change { Author.count }.by(0)
      end
      it 'falseを返すこと' do
        expect(google_book.save).not_to be_truthy
      end
    end
  
    context '適切な情報を持っているときは' do
      let(:google_book) { build(:google_book, authors: ['J.K.ローリング', 'JackThorne', 'JohnTiffany'])
      }
      it '保存できること' do
        expect { google_book.save }.to change { Book.count }.by(1).and change { Author.count }.by(3)
      end
      it 'trueを返すこと' do
        expect(google_book.save).to be_truthy
      end
    end
  
    context '著者の情報だけを持っていないときにも' do
      let(:google_book) { build(:google_book, authors: nil) }
      it '保存できること' do
        expect { google_book.save }.to change { Book.count }.by(1).and change { Author.count }.by(0)
      end
      it 'trueを返すこと' do
        expect(google_book.save).to be_truthy
      end
    end
  end
end