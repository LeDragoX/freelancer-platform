class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer

  validates :description, :hour_rate, :weekly_hours, :delivery_estimate,
            :project_id, :freelancer_id, presence: true

  validate :initialize_status

  enum status: { pending: 10, accepted: 20, rejected: 30 }

  private

  def initialize_status
    if status.nil?
      self.status = 10
    end
  end
end
