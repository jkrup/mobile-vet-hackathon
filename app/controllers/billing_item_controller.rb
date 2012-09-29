class BillingItemController < ApplicationController
  def new
    @billing_item = BillingItem.new
    if current_user.is_vet?
      @items = Items.where(:active => true)
    elsif current_user.is_technician?
      @items = Items.where(:action => true, :role => 'technician')
    else
      @items = []
    end

  end

  def create
    @billing_item = Billing.create(params[:billing_item])
  end
end
