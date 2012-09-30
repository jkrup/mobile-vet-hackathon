class UsersController < ApplicationController
  def show

    if current_user.is_client?
      @client = current_user

      @appointment_requests = @client.requests_for_vet
      @confirmed_visits = @client.confirmed_visits

      @nothing_is_going_on = @appointment_requests.blank? && @confirmed_appointments.blank?
    elsif current_user.is_provider?
      @provider = current_user

      @requests = @provider.appointment_requests
      @appointments = @provider.upcoming_visits
    end
  end
end
