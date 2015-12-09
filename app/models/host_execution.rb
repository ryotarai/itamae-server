class HostExecution < ActiveRecord::Base
  belongs_to :host
  belongs_to :execution

  has_many :events

  def updated_resource_count
    events.where(event_type: "resource_updated").count
  end
end
