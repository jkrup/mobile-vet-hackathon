class Request < ActiveRecord::Base
  has_one :assigned_vet, :class_name => "User"
  belongs_to :user
  attr_accessible :assigned_vet_id, :nos_serialized, :requested_slots_serialized, :round_count, :user_id, :visit_type

  def get_start_time
    JSON.parse(self.requested_slots_serialized)["day_starts"][0] #TODO: first day
  end
  def get_end_time
    JSON.parse(self.requested_slots_serialized)["day_ends"][0] #TODO: first day
  end
end
