Rails.application.routes.draw do
  #root 'application#hello'は動作テスト用のルーティング
  root 'application#home'
  namespace 'api' do
    namespace 'v1' do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      resources :tweets
    end
  end
end