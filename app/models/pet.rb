# == Schema Information
#
# Table name: pets
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  specie          :string(255)
#  age             :integer
#  medical_history :text
#  client_id       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Pet < ActiveRecord::Base
  attr_accessible :age, :medical_history, :name, :specie
  
  belongs_to :client, class_name: "User", foreign_key: "client_id"
end
