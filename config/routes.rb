Rails.application.routes.draw do
  root 'books#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :books do
    resources :reviews
  end

  resources :reviews, only: [] do
    resources :votes
  end

  resources :users, only: [:index, :destroy]

  resources :books, only: [] do
    resources :ranks
  end

  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :create]
      resources :votes
    end
  end

  get 'search' => 'books#search'
end
