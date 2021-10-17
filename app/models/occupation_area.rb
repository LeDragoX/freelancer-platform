class OccupationArea < ApplicationRecord
  has_many :profiles

  validates :name,
            presence: :true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 2, maximum: 100 }
end
