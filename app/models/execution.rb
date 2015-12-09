class Execution < ActiveRecord::Base
  belongs_to :revision
  has_many :host_executions

  validates :revision, presence: true
  if Figaro.env.allow_only_dry_run
    validates :dry_run, inclusion: {in: [true], message: ": Actual run is not allowed."}
  end

  after_create :enqueue_job

  private def enqueue_job
    ExecutionJob.perform_later(self)
  end
end
