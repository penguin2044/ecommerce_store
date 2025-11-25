Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
 root 'products#index'

  # Products routes
  resources :products, only: [:index, :show]

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
