Rails.application.routes.draw do
  #root 'application#hello'は動作テスト用のルーティング
  root 'application#home'
  #devise_for :users
  namespace 'api' do
    namespace 'v1' do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      resources :users, only: [:index, :show, :destroy] do
        resources :rooms, only: [:index, :show]
      end
      resources :chat_messages, only: [:create]
      resources :tweets, only: [:index, :show, :create, :destroy] do
        #resources :likes, only: [:create, :destroy]
         collection do
          get 'all'
        end
      end
    end
  end
end