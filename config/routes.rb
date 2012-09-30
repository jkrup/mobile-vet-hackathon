MobileVet::Application.routes.draw do
  get "users/show"


  devise_for :users

  resources :users, :visits, :billing_items, :pets, :payments

  root to: "users#show"

  get "requests/accept"
  get "requests/decline"
  resources :requests

end
#== Route Map
# Generated on 30 Sep 2012 04:43
#
#         new_user_session GET    /users/sign_in(.:format)          devise/sessions#new
#             user_session POST   /users/sign_in(.:format)          devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)         devise/sessions#destroy
#            user_password POST   /users/password(.:format)         devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)     devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
#                          PUT    /users/password(.:format)         devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)           devise/registrations#cancel
#        user_registration POST   /users(.:format)                  devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)          devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)             devise/registrations#edit
#                          PUT    /users(.:format)                  devise/registrations#update
#                          DELETE /users(.:format)                  devise/registrations#destroy
#                    users GET    /users(.:format)                  users#index
#                          POST   /users(.:format)                  users#create
#                 new_user GET    /users/new(.:format)              users#new
#                edit_user GET    /users/:id/edit(.:format)         users#edit
#                     user GET    /users/:id(.:format)              users#show
#                          PUT    /users/:id(.:format)              users#update
#                          DELETE /users/:id(.:format)              users#destroy
#                   visits GET    /visits(.:format)                 visits#index
#                          POST   /visits(.:format)                 visits#create
#                new_visit GET    /visits/new(.:format)             visits#new
#               edit_visit GET    /visits/:id/edit(.:format)        visits#edit
#                    visit GET    /visits/:id(.:format)             visits#show
#                          PUT    /visits/:id(.:format)             visits#update
#                          DELETE /visits/:id(.:format)             visits#destroy
#            billing_items GET    /billing_items(.:format)          billing_items#index
#                          POST   /billing_items(.:format)          billing_items#create
#         new_billing_item GET    /billing_items/new(.:format)      billing_items#new
#        edit_billing_item GET    /billing_items/:id/edit(.:format) billing_items#edit
#             billing_item GET    /billing_items/:id(.:format)      billing_items#show
#                          PUT    /billing_items/:id(.:format)      billing_items#update
#                          DELETE /billing_items/:id(.:format)      billing_items#destroy
#                     pets GET    /pets(.:format)                   pets#index
#                          POST   /pets(.:format)                   pets#create
#                  new_pet GET    /pets/new(.:format)               pets#new
#                 edit_pet GET    /pets/:id/edit(.:format)          pets#edit
#                      pet GET    /pets/:id(.:format)               pets#show
#                          PUT    /pets/:id(.:format)               pets#update
#                          DELETE /pets/:id(.:format)               pets#destroy
#                 payments GET    /payments(.:format)               payments#index
#                          POST   /payments(.:format)               payments#create
#              new_payment GET    /payments/new(.:format)           payments#new
#             edit_payment GET    /payments/:id/edit(.:format)      payments#edit
#                  payment GET    /payments/:id(.:format)           payments#show
#                          PUT    /payments/:id(.:format)           payments#update
#                          DELETE /payments/:id(.:format)           payments#destroy
#                     root        /                                 users#show
#                 requests GET    /requests(.:format)               requests#index
#                          POST   /requests(.:format)               requests#create
#              new_request GET    /requests/new(.:format)           requests#new
#             edit_request GET    /requests/:id/edit(.:format)      requests#edit
#                  request GET    /requests/:id(.:format)           requests#show
#                          PUT    /requests/:id(.:format)           requests#update
#                          DELETE /requests/:id(.:format)           requests#destroy
#          requests_accept GET    /requests/accept(.:format)        requests#accept
#         requests_decline GET    /requests/decline(.:format)       requests#decline
