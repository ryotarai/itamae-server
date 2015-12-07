class Execution < ActiveRecord::Base
  belongs_to :revision
  has_many :host_executions
  validates :revision, presence: true
  after_create :enqueue_job

  private def enqueue_job
    ExecutionJob.perform_later(self)
  end
end
