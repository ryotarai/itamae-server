class Plan < ActiveRecord::Base
  belongs_to :revision
  has_many :logs, dependent: :destroy

  enum status: {pending: 0, in_progress: 1, completed: 2, aborted: 3}

  validates :revision, presence: true

  after_commit :queue, on: :create

  def queue
    PlanWorker.perform_async(self.id)
  end

  def abort
    PlanAbortWorker.perform_async(self.id)
  end
end
