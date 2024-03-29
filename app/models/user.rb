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
#  role                    :string(255)      default("client")
#  availability_serialized :text
#  first_name              :string(255)
#  last_name               :string(255)
#  address                 :text
#  stripe_token            :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
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
  has_many :visits_from_provider, class_name: 'Visit', foreign_key: :client_id
  has_many :visits_to_client, class_name: 'Visit', foreign_key: :provider_id

  has_many :pets, foreign_key: "client_id"

  has_many :requests, foreign_key: :assigned_vet_id
  has_many :vet_requests, class_name: 'Request'

  ROLES = %W[vet client technician]
  validates_presence_of  :role
  validates_inclusion_of :role, in: ROLES

  ROLES.each do |role_name|
    define_method "is_#{role_name}?" do
      self.role == role_name
    end
  end

  def is_provider?
    self.is_vet? || self.is_technician?
  end

  # =================
  # Client methods
  # =================
  def requests_for_vet
    return (vet_requests || []) if is_client?
    []
  end

  def confirmed_visits
    return (visits_from_provider.hasnt_happened_yet || []) if is_client?
    []
  end

  # =================
  # vet/technician methods
  # =================
  def appointment_requests
    return (requests || []) if is_provider?
    []
  end


  def upcoming_visits
    return (visits_to_client.hasnt_happened_yet || []) if is_provider?
    []
  end

  def self.providers
    User.all.select { |user| %w(vet technician).include?(user.role) }
  end

end
