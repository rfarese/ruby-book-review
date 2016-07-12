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
end
