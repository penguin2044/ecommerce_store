Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # User authentication
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  # Set root to products index (homepage)
  root 'products#index'
  
  # Products routes
  resources :products, only: [:index, :show]
  
  # Cart routes
  get 'cart', to: 'cart#show', as: 'cart'
  post 'cart/add/:id', to: 'cart#add', as: 'add_to_cart'
  delete 'cart/remove/:id', to: 'cart#remove', as: 'remove_from_cart'
  patch 'cart/update_quantity/:id', to: 'cart#update_quantity', as: 'update_cart_quantity'
  delete 'cart/clear', to: 'cart#clear', as: 'clear_cart'
  
  # Checkout routes
  get 'checkout', to: 'checkout#new'
  post 'checkout/create', to: 'checkout#create'
  get 'checkout/success', to: 'checkout#success'
  
  # Pages routes
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end