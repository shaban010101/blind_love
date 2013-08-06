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

  resources :departments, :only => [:index, :show] do
    resources :categories, :only => [:index, :show], :shallow => true do
      resources :products, :only => [:index, :show], :shallow => true
    end
  end
  
  root :to => 'departments#index'
  
end
