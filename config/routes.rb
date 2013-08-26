BlindLove::Application.routes.draw do

	match "sessions/new" => "sessions#new", :as => "login"
  match "session" => "sessions#destroy", :as => "logout"
  get "search" => "categories#search"

  resources :admin, :only => [:index]
  resources :sessions, :only => [:new,:create,:destroy]
  resources :users, :only => [:edit,:create,:update,:new,:show,:destroy]
  resources :basket_items, :only =>[ :create, :destroy ]
  resources :baskets, :only => [ :show ]
  resources :payments, :only => [ :new, :create]

  namespace :admin do
    resources :products
    resources :categories
  end

  resources :categories, :only => [:index, :show], :shallow => true do
    resources :products, :only => [:index, :show], :shallow => true
  end
  
  root :to => 'categories#index'
  
end
