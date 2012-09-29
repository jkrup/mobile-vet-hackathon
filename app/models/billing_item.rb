class BillingItem < ActiveRecord::Base
  attr_accessible :item_id, :pet_id, :visit_id
  belongs_to :visit
  belongs_to :item
  belongs_to :pet
end
