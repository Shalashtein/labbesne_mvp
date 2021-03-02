class Lifestyle < ApplicationRecord
  belongs_to :profiles, class_name: "Profile"
  belongs_to :activity_levels, class_name: "ActivityLevel"
  belongs_to :job_types, class_name: "JobType"
  belongs_to :social_activities, class_name: "SocialActivity"
  belongs_to :outdoor_levels, class_name: "OutdoorLevel"

  validates :profiles_id, presence: true
  validates :activity_levels_id, presence: true
  validates :social_activities_id, presence: true
  validates :outdoor_levels_id, presence: true
end
