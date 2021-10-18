class Experience < ApplicationRecord
  belongs_to :profile

  validates :title, :started_at, :ended_at,
            :description, :profile_id,
            presence: true

  validate :started_at_lower_than_ended_at
  validate :ended_at_greater_than_started_at

  private

  def started_at_lower_than_ended_at
    if started_at > ended_at
      errors.add(:started_at, "não pode ser maior do que #{t(:ended_at, scope: "activerecord.attributes.experience")}")
    end
  end

  def ended_at_greater_than_started_at
    if ended_at < started_at
      errors.add(:ended_at, "não pode ser menor do que #{t(:started_at, scope: "activerecord.attributes.experience")}")
    end
  end
end
