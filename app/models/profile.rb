class Profile < ApplicationRecord
  belongs_to :occupation_area
  belongs_to :freelancer
  has_many :experiences, dependent: :destroy

  validates :full_name, :social_name, :birth_date,
            :formation, :occupation_area_id, :freelancer_id,
            presence: true
  # Description = Optional
  validates :full_name, length: { minimum: 3, maximum: 1000 }
  validates :social_name, length: { minimum: 1, maximum: 100 }
  validate :age_equal_more_than_sixteen

  private

  def age_equal_more_than_sixteen
    if birth_date.present? && birth_date >= 16.years.ago
      errors.add(:birth_date,
                 "não pode ser menor que #{Time.zone.now.year - 16.years.ago.year} anos " \
                 "(maior que #{I18n.l 16.years.ago.to_date})")
    end
  end
end
