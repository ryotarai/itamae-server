class Execution < ActiveRecord::Base
  belongs_to :revision
  has_many :host_executions, dependent: :destroy

  enum status: {pending: 0, in_progress: 1, completed: 2, aborted: 3}

  validates :revision, presence: true

  after_commit :queue, on: :create

  def queue
    ExecutionWorker.perform_async(self.id)
  end
end
