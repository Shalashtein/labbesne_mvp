class Profile < ApplicationRecord
  belongs_to :spree_user
  has_one :body_measurement
  has_one :lifestyle
  has_many :profile_specs
end
