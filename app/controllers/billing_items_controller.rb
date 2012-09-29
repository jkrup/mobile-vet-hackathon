class BillingItemsController < ApplicationController
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
    respond_to  do |format|
      format.js do  
        @billing_item = BillingItem.find_or_create_by_item_id_and_visit_id(item_id:params[:billing_item][:item_id], visit_id: params[:billing_item][:visit_id])
        #redirect_to Visit.find(params[:billing_item][:visit_id])
      end
    end  
  end
end
