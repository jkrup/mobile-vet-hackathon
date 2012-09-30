MobileVet::Application.routes.draw do
  get "users/show"
  get "requests/accept"

  devise_for :users

  root to: "users#show"

  get "requests/show"
  post "requests/schedule"

  resources :visits
  resources :billing_items
end
