require 'backend'

class PlanWorker
  include Sidekiq::Worker

  def perform(plan_id)
    plan = Plan.find(plan_id)

    unless plan.pending?
      Rails.logger.info "#{plan} is not pending. skip"
      return
    end

    plan.in_progress!
    plan.save!

    Backend.current.hosts.each do |host|
      plan.logs.create(host: host, status: :in_progress)
    end

  rescue => err
    Rails.logger.error "aborted: #{err.inspect}\n(backtrace)\n#{err.backtrace.join("\n")}"
    plan.aborted!
    plan.save!
  end
end

