BlindLove::Application.routes.draw do

	match "sessions/new" => "sessions#new", :as => "login"
  match "session" => "sessions#destroy", :as => "logout"
  get "search" => "categories#search"

  resources :admin, :only => [:index]
  resources :home_pages, :only => [:index]
  resources :sessions, :only => [:new,:create,:destroy]
  resources :users, :only => [:edit,:create,:update,:new,:show,:destroy]
  resources :basket_items, :only =>[ :create, :destroy ]
  resources :baskets, :only => [ :show ]

  resources :orders ,:only => [ :new, :create, :show] do
    member do
      get "shipping"
      get "review"
      get "payment"
      put "payment"
      put "review"
    end
  end

  namespace :admin do
    resources :products do
      member do
        get "sizing"
        put "sizing_update"
      end
    end
    resources :categories
    resources :categories_departments
  end

  resources :departments, :only => [:show], :shallow => true do
    resources :categories, :only => [:show] do
      resources :products, :only => [:show] do
      end
    end
  end

  post "categories/:id/", :to => "categories#show"

  root :to => 'home_pages#index'
end
