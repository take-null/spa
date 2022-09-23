require 'rails_helper'

RSpec.describe "Api::V1::Surveys", type: :request do
  describe 'Devise_token_authによる認証' do
    let(:current_user) { create(:user) }
    let(:params) { { email: current_user.email, password: current_user.password } }
    let(:token) { sign_in current_user }
    it 'createアクションが有効な事' do
      @survey = FactoryBot.create(:survey)
      post api_v1_surveys_path,
      params: { title: @survey.title, content: @survey.content },
      headers: token
      expect(response.status).to eq(200)
      puts response.body
    end
  end
end
