require 'backend'

class ExecutionAbortWorker
  include Sidekiq::Worker

  def perform(execution_id)
    execution = Execution.find(execution_id)

    if execution.aborted?
      Rails.logger.info "#{execution} is already aborted. skip"
      return
    end

    execution.aborted!

    Backend.current.abort(execution)
  end
end

