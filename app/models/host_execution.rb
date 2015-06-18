require 'storage'

class HostExecution < ActiveRecord::Base
  belongs_to :execution

  enum status: {pending: 0, in_progress: 1, completed: 2, aborted: 3}

  validates :execution, presence: true

  after_commit :update_execution_status

  def append_log(text)
    key = "#{log_key_prefix}/#{Time.now.to_i}.txt"
    Storage.current.store(key, text)
  end

  def read_log
    Storage.current.read_and_join_under(log_key_prefix)
  end

  private

  def log_key_prefix
    "host_executions/#{self.id}/logs"
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
