class Project < ApplicationRecord
  belongs_to :job_type
  belongs_to :user

  validates :title, :description, :wanted_skills,
  :max_hour_rate, :deadline,
  :job_type_id, :user_id, presence: :true

  validate :initialize_status
  validate :deadline_must_be_future

  enum status: { receiving_proposals: 10, in_progress: 20, finished: 30 }

  private

  def initialize_status
    if status.nil?
      self.receiving_proposals!
    end
  end

  def deadline_must_be_future
    if !deadline.nil? && deadline < Date.today
      errors.add(:deadline, 'não pode ser em datas passadas')
    end
  end
end
