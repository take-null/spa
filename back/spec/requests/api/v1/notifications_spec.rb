require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe 'Devise_token_authによる認証' do
    let(:current_user) { create(:user) }
    let(:params) { { email: current_user.email, password: current_user.password } }
    let(:token) { sign_in current_user }
    it 'indexアクションが有効な事' do
      get api_v1_notifications_path,
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'destroyアクションが有効な事'do
      @notification = FactoryBot.create(:notification)
      delete "/api/v1/notifications/#{@notification.id}",
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
  end 
end