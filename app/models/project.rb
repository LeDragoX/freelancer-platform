class Project < ApplicationRecord
  belongs_to :job_type
  belongs_to :user

  has_many :freelancers, through: :proposals
  has_many :proposals

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

  private

  def initialize_status
    if status.nil?
      self.status = 10
    end
  end

  def deadline_must_be_in_future
    if !deadline.nil? && deadline < Time.now.to_date
      errors.add(:deadline, "não pode ser em datas passadas")
    elsif !deadline.nil? && deadline == Time.now.to_date
      errors.add(:deadline, "não pode ser hoje")
    end
  end

  def max_hour_rate_must_be_zero_or_more
    if !max_hour_rate.nil? && max_hour_rate < 0
      errors.add(:max_hour_rate, "deve ser maior que zero")
    end
  end
end