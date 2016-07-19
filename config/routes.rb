Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
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
    end
  end

  get 'search' => 'books#search'
end
