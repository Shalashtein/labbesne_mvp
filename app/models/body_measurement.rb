class BodyMeasurement < ApplicationRecord
  belongs_to :profiles
  belongs_to :body_types
end
