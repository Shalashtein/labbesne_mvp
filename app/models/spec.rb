class Spec < ApplicationRecord
  has_one :profile_specs, dependent: :destroy
  has_one :product_specs, dependent: :destroy
end
