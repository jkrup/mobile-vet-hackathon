# == Schema Information
#
# Table name: visits
#
#  id             :integer          not null, primary key
#  is_home        :boolean
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
  attr_accessible :is_home, :start_time, :visit_type, :provider_id, :client_id
  belongs_to :client, class_name: 'User', foreign_key: :client_id
  belongs_to :provider, class_name: 'User', foreign_key: :provider_id # the vet
  has_many :billing_items


  workflow do
    state :performing_procedure do
      event :finish_procedure, transitions_to: :checkout
    end

    state :checkout do
      event :finish_checkout, transitions_to: :complete
    end

    state :complete
  end

  def self.hasnt_happened_yet
    where "workflow_state = 'performing_procedure'"
    # waiting_for_client?
  end

  def provider_type
    provider.role
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
