class HostExecution < ActiveRecord::Base
  belongs_to :execution

  enum status: {pending: 0, in_progress: 1, completed: 2, aborted: 3}

  before_save :set_defaults
  after_commit :update_execution_status

  def append_log(text)
    open(absolute_file_path, "a") do |f|
      f.write(text)
    end
  end

  def absolute_file_path
    Rails.root.join('public', self.file_path)
  end

  private

  def set_defaults
    self.file_path ||= File.join("files", "host_executions", SecureRandom.uuid)
  end

  def update_execution_status
    if self.execution.in_progress? && self.execution.host_executions.all? {|host_execution| host_execution.completed? }
      self.execution.completed!
    end

    if !self.execution.aborted? && self.aborted?
      self.execution.aborted!
    end
  end
end
