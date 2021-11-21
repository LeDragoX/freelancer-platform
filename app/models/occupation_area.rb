class OccupationArea < ApplicationRecord
  has_many :profiles, dependent: :nullify

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 }
end
