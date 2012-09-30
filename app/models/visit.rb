# == Schema Information
#
# Table name: visits
#
#  id             :integer          not null, primary key
#  is_home        :boolean
#  appointment_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  client_id      :integer
#  provider_id    :integer
#  workflow_state :string(255)
#  start_time     :time
#  visit_type     :string(255)
#

class Visit < ActiveRecord::Base
  include Workflow
  attr_accessible :appointment_id, :is_home, :start_time, :visit_type, :provider_id, :client_id
  belongs_to :client, class_name: 'User', foreign_key: :client_id
  belongs_to :provider, class_name: 'User', foreign_key: :provider_id # the vet
  has_many :billing_items

  def provider_type
    provider.role
  end
  workflow do
    state :waiting_for_client do
      event :checkin, :transitions_to => :assessment
      event :bill_client_no_show, :transitions_to => :complete
    end
    
    state :assessment do 
      event :finish_assessment, :transitions_to => :performing_procedure
    end
    
    state :performing_procedure do 
      event :finish_procedure, :transitions_to => :checkout
    end

    state :checkout do
      event :finish_checkout, :transitions_to => :complete
    end
    
    state :complete
  end

  def do_finish_assessment visit_attr
    finish_assessment!
  end

  def do_finish_procedure visit_attr
    finish_procedure!
  end

  def do_checkin visit_attr
    is_home=true
    checkin!
    save!
  end
  
  def do_finish_checkout visit_attr
    # TODO charge credit card
    #
    finish_checkout!
  end

  def do_bill_client_no_show visit_attr
    # TODO charge for no show
    bill_client_no_show!
  end
  def next_step (visit_attr = {})
    self.send "do_#{visit_attr[:next_step]}", visit_attr
  end

  def visit_total
    sum = (billing_items || []).reduce(0.0){|sum, billing_item| sum += billing_item.item.price; sum}
  end

end
