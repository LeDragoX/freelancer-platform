class Project < ApplicationRecord
  belongs_to :job_type
  belongs_to :user

  validates :title, :description, :wanted_skills,
  :max_hour_rate, :deadline,
  :job_type_id, :user_id, presence: :true
end
