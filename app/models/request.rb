class Request < ActiveRecord::Base
  has_one :assigned_vet, :class_name => "User"
  belongs_to :user
  attr_accessible :assigned_vet_id, :nos_serialized, :requested_slots_serialized, :round_count, :user_id, :visit_type
end
