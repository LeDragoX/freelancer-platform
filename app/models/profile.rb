class Profile < ApplicationRecord
  belongs_to :occupation_area
  belongs_to :freelancer
end
