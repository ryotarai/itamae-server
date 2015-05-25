require 'backend'

class PlanAbortWorker
  include Sidekiq::Worker

  def perform(plan_id)
    plan = Plan.find(plan_id)

    if plan.aborted?
      Rails.logger.info "#{plan} is already aborted. skip"
      return
    end

    plan.aborted!

    Backend.current.abort(plan)
  end
end

