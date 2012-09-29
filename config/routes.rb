MobileVet::Application.routes.draw do
  devise_for :users

  root to: "users#index"
  match "appointments/show", to: 'appointments#show'
  match "appointments/schedule", to: 'appointments#schedule'

  resources :visits
  resources :billing_items
end
