# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  role                    :string(255)
#  availability_serialized :text
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :availability
  # attr_accessible :title, :body
  has_many :client_visits, class_name: 'Visit', foreign_key: :client_id
  has_many :provider_visits, class_name: 'Visit', foreign_key: :provider_id

  has_many :pets, foreign_key: "client_id"

  has_many :requests

  def is_vet?
    role == "vet"
  end

  def is_client?
    role == "client"
  end

  def is_technician?
    role == "technician"
  end

  def outstanding_requests
    Request.where(assigned_vet_id: 4)
  end
end
