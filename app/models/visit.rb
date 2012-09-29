class Visit < ActiveRecord::Base
  include Workflow
  attr_accessible :appointment_id, :is_home
  belongs_to :client, class_name: 'User', foreign_key: :client_id
  belongs_to :provider, class_name: 'User', foreign_key: :provider_id
  has_many :billing_items

  workflow do
    state :waiting_for_client do
      event :checkin, :transitions_to => :performing_procedure
      event :bill_client_no_show, :transitions_to => :complete
    end

    state :performing_procedure do 
      event :finish_procedure, :transitions_to => :checkout
    end

    state :checkout do
      event :finish_checkout, :transitions_to => :complete
    end
    
    state :complete
  end

  def do_checkin visit_attr
    is_home=true
    checkin!
    save!
  end
  def next_step (visit_attr = {})
    self.send "do_#{visit_attr[:next_step]}", visit_attr
  end
end
