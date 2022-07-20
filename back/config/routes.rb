Rails.application.routes.draw do
  #root 'application#hello'は動作テスト用のルーティング
  root 'application#home'
  #devise_for :users
  namespace 'api' do
    namespace 'v1' do
      #devise_scope :api_v1_user do
        #resources :users, only: [:search] do
         #collection do
           #get 'search'
          #end
        #end
      #end
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      devise_scope :api_v1_user do
        resources :users, only: [:index, :show, :destroy] do
          collection do
            get 'search'
          end
          member do
            get :following, :followers
          end
        #resources :rooms, only: [:index, :show]
        end
      end
      resources :relationships, only: [:create, :destroy]
      resources :chat_messages, only: [:create]
      resources :tweets, only: [:index, :show, :create, :destroy] do
        resources :likes, only: [:create, :destroy]
         collection do
           get 'all'
         end
      end
      resources :books, only: [:create, :show], shallow: true do
        collection do
          get :search
        end
      end
      resources :books_shelves, only: [:index, :show, :create]
    end
  end
end