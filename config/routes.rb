MobileVet::Application.routes.draw do
  devise_for :users

  root to: "users#index"

  resources :visits
  resources :billing_items

  match "appointments/show", to: 'appointments#show'
  match "appointments/schedule", to: 'appointments#schedule'

end
