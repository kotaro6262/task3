Rails.application.routes.draw do

  devise_for :users
  root "homes#top"
  get "home/about" => 'homes#about'
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :index, :edit, :update]

end
