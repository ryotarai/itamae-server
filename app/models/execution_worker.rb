require 'backend'

class ExecutionWorker
  include Sidekiq::Worker

  def perform(execution_id)
    execution = Execution.find(execution_id)

    unless execution.in_progress?
      Rails.logger.info "#{execution} is not in progress. skip"
      return
    end

    execution.in_progress!

    Backend.current.kick(execution)
  rescue => err
    Rails.logger.error "aborted: #{err.inspect}\n(backtrace)\n#{err.backtrace.join("\n")}"
    execution.aborted!
  end
end
