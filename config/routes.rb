Rails.application.routes.draw do
  get "checkout", to: "checkout#index"

  resources :products
  resources :cart_items
  resources :orders, only: [:create, :show]

  get "up" => "rails/health#show", as: :rails_health_check
end