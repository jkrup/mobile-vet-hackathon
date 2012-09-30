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

require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
