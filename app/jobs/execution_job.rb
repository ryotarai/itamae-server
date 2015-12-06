class ExecutionJob < ActiveJob::Base
  queue_as :default

  def perform(execution)
  end
end
