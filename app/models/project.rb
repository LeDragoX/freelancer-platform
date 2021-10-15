class Project < ApplicationRecord
  belongs_to :user

  validates :title, :description, :wanted_skills, :hour_rate, :deadline,
  :job_type, :available, :status, :user_id, presence: :true
end
