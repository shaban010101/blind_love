BlindLove::Application.routes.draw do
  root :to => 'home_pages#index'
  
  devise_for :users

  devise_scope :user do
    match "/users/sign_in" => "devise/sessions#new", :as => "login"
    match "/users/sign_out" => "devise/sessions#destroy", :as => "logout"
  end

  put "/orders/", :to => "orders#update_basket_item"
  delete "/orders/", :to => "basketItems#destroy"
  
  post "departments/:department_id/categories/:id/", :to => "categories#show"
  
  put "admin/orders", :to => "admin/orders#update"
  
  resources :searches, :only => [:index]
  resources :admin, :only => [:index]
  resources :home_pages, :only => [:index]
  resources :basket_items, :only =>[ :create, :destroy]
  resources :orders ,:only => [ :new, :create]

  resources :baskets, :only => [ :show ] do
    member do
      put "update_basket_item"
    end
  end

  resources :users, :except => [:index] do
    resources :addresses
    resources :payments
    resources :orders, :only => [:index, :show] do
      member do
        put "cancel"
      end
    end
  end

  namespace :admin do
    resources :products
    resources :categories
    resources :orders
  end

  resources :departments, :only => [:show] do
    resources :categories, :only => [:show] do
      resources :products, :only => [:show], :shallow => true do
      end
    end
  end
end
