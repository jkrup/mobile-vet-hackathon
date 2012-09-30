MobileVet::Application.routes.draw do
  get "users/show"

  devise_for :users

  resources :visits, :billing_items, :pets, :payments

  root to: "users#show"
  match "requests/show", to: 'requests#show'
  match "requests/schedule", to: 'requests#schedule'

end
