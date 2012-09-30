class UsersController < ApplicationController
  respond_to :html, :js

  def show

    if current_user.is_client?
      @client = current_user

      @requests = @client.requests_for_vet
      @visits = @client.confirmed_visits

      @nothing_is_going_on = @requests.blank? && @visits.blank?
    elsif current_user.is_provider?
      @provider = current_user

      @requests = @provider.appointment_requests
      @visits = @provider.upcoming_visits
    end

    respond_with @requests, @visits, @nothing_is_going_on do |format|
      format.js
      format.html
    end
  end
end
