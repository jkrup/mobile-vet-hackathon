class UsersController < ApplicationController
  def show
    @visits = current_user.client_visits if current_user.is_client?

    @appointments = current_user.provider_visits if current_user.is_technician? || current_user.is_vet?
    @requests = current_user.outstanding_requests if current_user.is_technician? || current_user.is_vet?
  end
end
