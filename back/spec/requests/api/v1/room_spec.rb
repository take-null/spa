require 'rails_helper'

RSpec.describe "Api::V1::Rooms", type: :request do
  describe 'Room' do
    before(:each) do
      @room = FactoryBot.create(:room)
    end
    it 'messagesアクションが有効な事' do
      get "/api/v1/rooms/messages?id=#{@room.id}"
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
  end
  describe 'Devise_token_authによる認証' do
    let(:current_user) { create(:user) }
    let(:params) { { email: current_user.email, password: current_user.password } }
    let(:token) { sign_in current_user }
    it 'indexアクションが有効な事' do
      get '/api/v1/rooms',
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'createアクションが有効な事' do
      @user = FactoryBot.create(:user)
      post "/api/v1/users/#{@user.id}/rooms",
      params: { id: @user.id },
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'showアクションが有効な事'do
      @room = FactoryBot.create(:room)
      get "/api/v1/rooms/#{@room.id}",
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
  end
end