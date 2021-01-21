class Profile < ApplicationRecord
  belongs_to :spree_user, class_name: "Spree::User"
  has_one :body_measurement, class_name: "BodyMeasurement", foreign_key: "profiles_id"
  has_one :lifestyle, class_name: "Lifestyle", foreign_key: "profiles_id"
  has_one :info, class_name: "Info", foreign_key: "profiles_id"
  has_many :profile_specs, class_name: "ProfileSpec", foreign_key: "profiles_id"
end
