BlindLove::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    match "/users/sign_in" => "devise/sessions#new", :as => "login"
    match "/users/sign_out" => "devise/sessions#destroy", :as => "logout"
  end
  
  resources :searches, :only => [:index]

  resources :admin, :only => [:index]
  resources :home_pages, :only => [:index]
  # resources :sessions, :only => [:new,:create,:destroy]
  resources :users, :only => [:edit,:create,:update,:new,:show,:destroy]
  resources :basket_items, :only =>[ :create, :destroy, :update ]
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
