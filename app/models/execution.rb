class Execution < ActiveRecord::Base
  belongs_to :revision
  has_many :host_executions, dependent: :destroy

  enum status: {in_progress: 1, completed: 2, aborted: 3}

  validates :revision, presence: true
  validates :is_dry_run, inclusion: [true, false]
  validate :validate_revision_is_active

  def queue
    ExecutionWorker.perform_async(self.id)
  end

  def dry_run?
    self.is_dry_run
  end

  def actual_run?
    !dry_run?
  end

  def validate_revision_is_active
    if self.actual_run? && !self.revision.active?
      errors.add(:revision, "Revision should be active on actual run")
    end
  end
end
