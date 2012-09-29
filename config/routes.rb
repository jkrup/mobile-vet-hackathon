MobileVet::Application.routes.draw do
  devise_for :users

  root to: "users#index"
  resources :visits
  resources :billing_items
end
