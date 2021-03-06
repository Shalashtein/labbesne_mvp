class ProfileColor < ApplicationRecord
  belongs_to :profile, class_name: "Profile"
end
