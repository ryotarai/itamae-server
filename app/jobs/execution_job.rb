class ExecutionJob < ActiveJob::Base
  queue_as :default

  def perform(execution)
    ItamaeServer::Backend.instance.execute(execution)
  end
end
