class VisitsController < ApplicationController
  def show
    @visit = Visit.find params[:id]
    @items = Item.all
    @billing_items = BillingItem.all
  end

  def update
    @visit = Visit.find params[:id]
    @visit.next_step params
    redirect_to @visit
  end
end
