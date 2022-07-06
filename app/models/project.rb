class Project < ApplicationRecord
  belongs_to :job_type
  belongs_to :user

  has_many :freelancers, through: :proposals
  has_many :proposals, dependent: :destroy

  validates :title, :description, :wanted_skills,
            :max_hour_rate, :deadline,
            :job_type_id, :user_id, presence: true
  validates :title, length: { minimum: 1, maximum: 100 }
  validates :description, length: { minimum: 20, maximum: 1000 }
  validates :wanted_skills, length: { minimum: 5, maximum: 1000 }

  validate :deadline_must_be_in_future
  validate :initialize_status
  validate :max_hour_rate_must_be_zero_or_more

  enum status: { receiving_proposals: 10, in_progress: 20, finished: 30 }

  def owner?(current_user = nil)
    user == current_user
  end

  private

  def initialize_status
    self.status = 10 if status.nil?
  end

  def deadline_must_be_in_future
    if deadline.present?
      return errors.add(:deadline, 'não pode ser em datas passadas') if deadline < Time.zone.now.to_date

      errors.add(:deadline, 'não pode ser hoje') if deadline == Time.zone.now.to_date
    end
  end

  def max_hour_rate_must_be_zero_or_more
    errors.add(:max_hour_rate, 'deve ser maior que zero') if max_hour_rate.present? && max_hour_rate.negative?
  end
end
