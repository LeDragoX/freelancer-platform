class Profile < ApplicationRecord
  belongs_to :occupation_area
  belongs_to :freelancer
  has_many :experiences, dependent: :destroy

  validates :full_name, :social_name, :birth_date,
            :formation, :occupation_area_id, :freelancer_id,
            presence: true
  validates :freelancer_id, uniqueness: true
end
