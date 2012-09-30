class UsersController < ApplicationController
  def show
    @visits = current_user.client_visits if current_user.is_client?
    @visits = current_user.provider_visits if current_user.is_technician? or current_user.is_vet?
  end
end
