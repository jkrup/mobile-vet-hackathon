class PaymentsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = current_user
    @user.stripe_token = "abcthisisafakestripetokenhahahahalul"
    @user.save!
    redirect_to root_url
  end
end
