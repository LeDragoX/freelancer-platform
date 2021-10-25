class JobType < ApplicationRecord
  has_many :projects

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 50 }
end