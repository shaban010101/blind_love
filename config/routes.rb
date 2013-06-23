BlindLove::Application.routes.draw do

	match "new_session" => "sessions#new", :as => "login"
  match "session" => "sessions#destroy", :as => "logout"

  resources :admin, :only => [:index]
  resources :sessions, :only => [:new,:create,:destroy]
  resources :users, :only => [:edit,:create,:update,:new,:show,:destroy]

  namespace :admin do
    resources :products
    resources :categories
    resources :departments
  end
  
  root :to => 'sessions#new'
  
end
