Rails.application.routes.draw do
  #root 'application#hello'は動作テスト用のルーティング
  root 'application#home'
  devise_for :users
  namespace 'api' do
    namespace 'v1' do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      #ユーザー検索機能用？
      resources :users, only: [:index, :show, :destroy]
      resources :tweets, only: [:index, :show, :create, :destroy] do
        resources :likes, only: [:create, :destroy]
      end
    end
  end
end