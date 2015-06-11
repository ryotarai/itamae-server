require 'backend'

class ExecutionWorker
  include Sidekiq::Worker

  def perform(execution_id)
    execution = Execution.find(execution_id)

    unless execution.pending?
      Rails.logger.info "#{execution} is not pending. skip"
      return
    end

    execution.in_progress!

    Backend.current.hosts.each do |host|
      execution.logs.create(host: host, status: :pending)
    end

    Backend.current.kick(execution)
  rescue => err
    Rails.logger.error "aborted: #{err.inspect}\n(backtrace)\n#{err.backtrace.join("\n")}"
    execution.aborted!
  end
end

