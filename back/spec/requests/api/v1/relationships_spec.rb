require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe 'Devise_token_authによる認証' do
    let(:current_user) { create(:user) }
    let(:params) { { email: current_user.email, password: current_user.password } }
    let(:token) { sign_in current_user }
    it 'createアクションが有効な事' do
      @other_user = FactoryBot.create(:user)
      post api_v1_relationships_path,
      params: { user_id: current_user.id, followed_id: @other_user.id },
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
    it 'destroyアクションが有効な事'do
      @other_user = FactoryBot.create(:user)
      post api_v1_relationships_path,
      params: { user_id: current_user.id, followed_id: @other_user.id },
      headers: token
      delete "/api/v1/relationships/#{@other_user.id}",
      params: { user_id: current_user.id, followed_id: @other_user.id },
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
  end
end