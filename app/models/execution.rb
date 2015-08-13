class Execution < ActiveRecord::Base
  belongs_to :revision
  has_many :host_executions, dependent: :destroy

  enum status: {in_progress: 1, completed: 2, aborted: 3}

  validates :revision, presence: true
  validates :is_dry_run, inclusion: [true, false]

  def queue
    ExecutionWorker.perform_async(self.id)
  end
end
