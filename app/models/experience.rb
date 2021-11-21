class Experience < ApplicationRecord
  belongs_to :profile

  validates :title, :started_at, :ended_at,
            :description, :profile_id, presence: true
  validates :title, length: { minimum: 3, maximum: 70 }
  validates :description, length: { minimum: 20, maximum: 1000 }

  validate :started_at_lower_than_ended_at
  validate :ended_at_greater_than_started_at

  def owner?(current_freelancer = nil)
    profile.freelancer == current_freelancer
  end

  private

  def started_at_lower_than_ended_at
    if (started_at.present? && ended_at.present?) && started_at > ended_at
      errors.add(:started_at,
                 "não pode ser maior do que #{I18n.t(:ended_at, scope: 'activerecord.attributes.experience')}")
    end
  end

  def ended_at_greater_than_started_at
    if (ended_at.present? && started_at.present?) && ended_at < started_at
      errors.add(:ended_at,
                 "não pode ser menor do que #{I18n.t(:started_at, scope: 'activerecord.attributes.experience')}")
    end
  end
end
