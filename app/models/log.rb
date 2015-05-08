class Log < ActiveRecord::Base
  belongs_to :plan
  enum status: {pending: 0, in_progress: 1, completed: 2, aborted: 3}

  before_save :set_defaults

  def append(text)
    open(absolute_file_path, "a") do |f|
      f.write(text)
    end
  end

  private

  def set_defaults
    self.file_path ||= File.join("files", "logs", SecureRandom.uuid)
  end

  def absolute_file_path
    Rails.root.join(self.file_path)
  end
end
