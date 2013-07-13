BlindLove::Application.routes.draw do

	match "sessions/new" => "sessions#new", :as => "login"
  match "session" => "sessions#destroy", :as => "logout"

  resources :admin, :only => [:index]
  resources :departments, :only => [:index, :show]
  resources :sessions, :only => [:new,:create,:destroy]
  resources :users, :only => [:edit,:create,:update,:new,:show,:destroy]

  namespace :admin do
    resources :products
    resources :categories
    resources :departments
  end
  
  root :to => 'sessions#new'
  
end
