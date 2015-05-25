class Log < ActiveRecord::Base
  belongs_to :plan

  enum status: {pending: 0, in_progress: 1, completed: 2, aborted: 3}

  before_save :set_defaults
  after_commit :update_plan_status

  def append(text)
    open(absolute_file_path, "a") do |f|
      f.write(text)
    end
  end

  def absolute_file_path
    Rails.root.join('public', self.file_path)
  end

  private

  def set_defaults
    self.file_path ||= File.join("files", "logs", SecureRandom.uuid)
  end

  def update_plan_status
    if self.plan.in_progress? && self.plan.logs.all? {|log| log.completed? }
      self.plan.completed!
    end

    if !self.plan.aborted? && self.aborted?
      self.plan.aborted!
    end
  end
end
