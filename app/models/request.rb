# == Schema Information
#
# Table name: appointments
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
  has_one :assigned_vet, :class_name => "User"
  belongs_to :user
  attr_accessible :assigned_vet_id, :nos_serialized, :requested_slots_serialized, :round_count, :user_id, :visit_type
end
