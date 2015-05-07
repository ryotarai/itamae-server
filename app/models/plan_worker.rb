class PlanWorker
  include Sidekiq::Worker

  def perform(plan_id)
    plan = Plan.find(plan_id)

    unless plan.pending?
      Rails.logger.info "#{plan} is not pending. skip"
      return
    end

    plan.status = :in_progress
    plan.save!

    Backend.current.hosts.each do |host|
      plan.logs.create(host: host)
    end
  end
end

