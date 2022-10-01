require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'User' do
    before do
      @user = create(:user)
    end

    it 'searchアクションが有効な事' do
      get search_api_v1_users_path params: { email: @user.email }
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end

    it 'showアクションが有効な事' do
      get api_v1_user_path(@user.id)
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end

    it 'destroyアクションが有効な事' do
      delete api_v1_user_path(@user.id)
      JSON.parse(response.body)
      expect(response.status).to eq(200)
      puts response.body
    end
  end
end
