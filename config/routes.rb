BlindLove::Application.routes.draw do

	get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  resources :admin, :only => [:index]

  resources :sessions, :only => [:create,:destroy]

  namespace :admin do
    resources :products
    resources :categories
  end
  
  root :to => 'sessions#new'
  
end
