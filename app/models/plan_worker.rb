class PlanWorker
  include Sidekiq::Worker

  def perform(plan_id)
    plan = Plan.find(plan_id)

    unless plan.pending?
      puts "#{plan} is not pending"
    end

    plan.status = :in_progress
    plan.save!
  end
end

