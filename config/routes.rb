Rails.application.routes.draw do
  devise_for :users
  
  resources :order_items
  resources :orders
  resources :cart_items
  resources :carts
  resources :brands
  resources :products
  resources :addresses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
