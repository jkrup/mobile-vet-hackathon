# == Schema Information
#
# Table name: requests
#
#  id                         :integer          not null, primary key
#  requested_slots_serialized :text
#  user_id                    :integer
#  assigned_vet_id            :integer
#  round_count                :integer
#  visit_type                 :string(255)
#  nos_serialized             :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Request < ActiveRecord::Base

  belongs_to :assigned_vet, :class_name => "User"
  belongs_to :client, class_name: 'User', foreign_key: :user_id
  attr_accessible :assigned_vet_id, :nos_serialized, :requested_slots_serialized, :round_count, :user_id, :visit_type

  def nos
    JSON.parse(self.nos_serialized)
  end
  # input array ---> serialized text
  def nos= ( the_nos )
    self.nos_serialized = the_nos.to_json
  end
  def get_start_time
    JSON.parse(self.requested_slots_serialized)["day_starts"][0] #TODO: first day
  end

  def get_end_time
    JSON.parse(self.requested_slots_serialized)["day_ends"][0] #TODO: first day
  end
end
