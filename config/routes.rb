Rails.application.routes.draw do

    devise_for :users

  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"
 

  delete 'books/:id' => 'books#destroy', as: 'destroy_book'

  resources :books, only:[:index, :show, :create, :update, :edit] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :index, :update]
  
end