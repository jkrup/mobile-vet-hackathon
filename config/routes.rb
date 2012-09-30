MobileVet::Application.routes.draw do
  get "users/show"
  get "requests/accept"
  get "requests/decline"

  devise_for :users

  resources :visits, :billing_items, :pets, :payments

  root to: "users#show"

  get "requests/show"
  post "requests/schedule"

end
