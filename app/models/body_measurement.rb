class BodyMeasurement < ApplicationRecord
  belongs_to :profiles, class_name: 'Profile'
  belongs_to :body_types, class_name: 'BodyType'

  validates :profiles_id, presence: true
  validates :body_types_id, presence: :true
  validates :height, presence: :true,
                     numericality: { greater_than_or_equal_to: 60, less_than_or_equal_to: 260, message: "Please enter the correct height in cm" }
  validates :weight, presence: :true,
                     numericality: { greater_than_or_equal_to: 30, less_than_or_equal_to: 260, message: "Please enter the correct weight in kg" }
  validates :shirt_size, presence: :true, inclusion: { in: %w[XS S M L XL XXL],
                                                       message: "%{value} is not a valid size" }
  validates :pants_size, presence: :true,
                         numericality: { greater_than_or_equal_to: 26, less_than_or_equal_to: 60, message: "Please enter the correct pants size" }
  validates :shoe_size, presence: :true,
                        numericality: { greater_than_or_equal_to: 34, less_than_or_equal_to: 52, message: "Please enter the correct shoe size" }
end
