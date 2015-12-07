class HostExecution < ActiveRecord::Base
  belongs_to :host
  belongs_to :execution

  has_many :events
end
