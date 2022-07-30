Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
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
      resources :books, only: [:create, :show], shallow: true do
        collection do
          get :search
        end
      end
      resources :books_shelves, only: [:index, :show, :create] do
        collection do
          get :all
          get :user
          get :rank
          get :tag
          get :search
          get :view
        end
      end
      resources :goods, only: [:index, :create, :destroy]
      resources :notifications, only: [:index, :destroy]
    end
  end
end