require 'rails_helper'

RSpec.describe 'Goods', type: :request do
  describe 'Devise_token_authによる認証' do
    let(:current_user) { create(:user) }
    let(:params) { { email: current_user.email, password: current_user.password } }
    let(:token) { sign_in current_user }

    it 'indexアクションが有効な事' do
      @books_shelf = FactoryBot.create(:books_shelf)
      get api_v1_goods_path,
          params: { books_shelf_id: @books_shelf.id },
          headers: token
      expect(response.status).to eq(200)
      puts response.body
    end

    it 'createアクションが有効な事' do
      @books_shelf = FactoryBot.create(:books_shelf)
      post api_v1_goods_path,
           params: { books_shelf_id: @books_shelf.id },
           headers: token
      expect(response.status).to eq(200)
      puts response.body
    end

    it 'destroyアクションが有効な事' do
      @good = FactoryBot.create(:good)
      delete "/api/v1/goods/#{@good.id}",
             params: { books_shelf_id: @good.id },
             headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
  end
end
