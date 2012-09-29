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

class BillingItem < ActiveRecord::Base
  attr_accessible :item_id, :pet_id, :visit_id
  belongs_to :visit
  belongs_to :item
  belongs_to :pet
end
