class JobType < ApplicationRecord
  has_many :projects, dependent: :nullify

  validates :name,
            presence: true,
            length: { minimum: 3, maximum: 50 }
end
