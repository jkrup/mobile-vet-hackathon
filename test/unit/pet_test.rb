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

require 'test_helper'

class PetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
