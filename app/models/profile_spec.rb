class ProfileSpec < ApplicationRecord
  belongs_to :profiles, class_name: 'Profile'
  belongs_to :specs, class_name: 'Spec'
end
