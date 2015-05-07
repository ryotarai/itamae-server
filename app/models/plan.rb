class Plan < ActiveRecord::Base
  belongs_to :revision
  enum status: {pending: 0, in_progress: 1, completed: 2, aborted: 3}
end
