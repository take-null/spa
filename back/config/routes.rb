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
            resources :rooms, only: [:create]
          end
        end
      end
      resources :rooms, only: [:index, :show] do
        collection do
          get 'messages'
        end
      end
      resources :relationships, only: [:create, :destroy]
      resources :books, only: [:create, :show], shallow: true do
        collection do
          get :search
        end
      end
      resources :books_shelves, only: [:index, :show, :create, :destroy] do
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