class Profile < ApplicationRecord
  belongs_to :occupation_area
  belongs_to :freelancer

  validates :full_name, :social_name, :birth_date,
            :formation, :description,
            :occupation_area_id, :freelancer_id,
            presence: :true
end
