Rails.application.routes.draw do
  resources :order_items
  resources :cart_items
  resources :orders
  resources :addresses
  resources :marcas
  devise_for :users
  
  resources :carts
  resources :brands
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
