MobileVet::Application.routes.draw do
  get "users/show"

  devise_for :users

  root to: "users#show"
  match "requests/show", to: 'requests#show'
  match "requests/schedule", to: 'requests#schedule'

  resources :visits
  resources :billing_items
end
