require 'rails_helper'

RSpec.describe "BooksShelves", type: :request do

  describe 'Devise_token_authによる認証' do
    let(:current_user) { create(:user) }
    let(:params) { { email: current_user.email, password: current_user.password } }
    let(:token) { sign_in current_user }
    it 'indexアクションが有効な事' do
      get api_v1_books_shelves_path, headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'createアクションが有効な事' do
      @book = FactoryBot.create(:book)
      post api_v1_books_shelves_path, 
      params: { comment: "第一作", rating: 5, google_books_api_id: "jfApAQAAMAAJ", tag_list: ["小説", "エッセイ", "芸術"] },
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
  end 
  describe 'Books_shelf' do
    before(:each) do
      @books_shelf = FactoryBot.create(:books_shelf)
    end  
    it 'destroyアクションが有効な事' do
      delete "/api/v1/books_shelves/#{@books_shelf.id}"
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'userアクションが有効な事' do
      @user = FactoryBot.create(:user)
      get user_api_v1_books_shelves_path(@user.id)
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'allアクションが有効な事' do
      get all_api_v1_books_shelves_path
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'tagアクションが有効な事' do
      get tag_api_v1_books_shelves_path
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'rankアクションが有効な事' do
      get rank_api_v1_books_shelves_path
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'searchアクションが有効な事' do
      get search_api_v1_books_shelves_path params: { tag: 'Foo' }
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'viewアクションが有効な事' do
      get view_api_v1_books_shelves_path params: { google_books_api_id: 'e529dosj7z5f' }
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
  end
end