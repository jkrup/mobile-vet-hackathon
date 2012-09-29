# == Schema Information
#
# Table name: billing_items
#
#  id         :integer          not null, primary key
#  visit_id   :integer
#  item_id    :integer
#  pet_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class BillingItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
