Rails.application.routes.draw do
  devise_for :users
  get 'books/index'
  root 'books#index'
  resources :books do
    resources :reviews
  end
end
