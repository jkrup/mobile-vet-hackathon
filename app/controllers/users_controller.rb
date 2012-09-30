class UsersController < ApplicationController
  def show
    if current_user.is_client?
      @client = current_user
      @visits = @client.requests_for_vet
    elsif current_user.is_provider?
      @provider = current_user
      @appointments = @provider.upcoming_appointments
      @requests = @provider.appointment_requests
    end
  end
end
