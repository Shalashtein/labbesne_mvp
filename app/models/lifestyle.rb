class Lifestyle < ApplicationRecord
  belongs_to :profiles
  belongs_to :activity_levels
  belongs_to :job_types
  belongs_to :social_activities
  belongs_to :outdoor_levels
end
