Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  #以下は動作テスト用のルーティング
  root 'application#hello'
  namespace 'api' do
    namespace 'v1' do
      resources :hello, only:[:index]
    end
  end
end
