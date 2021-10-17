class Experience < ApplicationRecord
  belongs_to :profile

  validates :title, :started_at, :ended_at,
            :description, :profile_id,
            presence: :true
end
