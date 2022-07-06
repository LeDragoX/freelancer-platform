class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer

  validates :description, :hour_rate, :weekly_hours, :delivery_estimate,
            :project_id, :freelancer_id, presence: true
  validates :description, length: { minimum: 20, maximum: 1000 }
  validates :hour_rate, length: { minimum: 1, maximum: 100 }

  validate :initialize_status
  validate :hour_rate_is_equal_or_less_than_project_rate
  validate :weekly_hours_is_more_than_zero
  validate :delivery_estimate_must_be_in_future

  enum status: { pending: 10, accepted: 20, rejected: 30 }

  def owner?(current_freelancer = nil)
    freelancer == current_freelancer
  end

  private

  def initialize_status
    self.status = 10 if status.blank?
  end

  def hour_rate_is_equal_or_less_than_project_rate
    if hour_rate.present? && hour_rate > project.max_hour_rate
      errors.add(:hour_rate, "deve ser menor ou igual a #{project.max_hour_rate}")
    end
  end

  def weekly_hours_is_more_than_zero
    errors.add(:weekly_hours, 'deve ser maior que zero') if weekly_hours.present? && weekly_hours < 1
  end

  def delivery_estimate_must_be_in_future
    if delivery_estimate.present?
      return errors.add(:delivery_estimate, 'não pode ser hoje') if delivery_estimate == Time.zone.now.to_date

      errors.add(:delivery_estimate, 'não pode ser em datas passadas') if delivery_estimate < Time.zone.now.to_date
    end
  end
end
