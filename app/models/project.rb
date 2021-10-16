class Project < ApplicationRecord
  belongs_to :user

  validates :title, :description, :wanted_skills, :max_hour_rate, :deadline,
  :job_type, :available, :status, :user_id, presence: :true
end
