class Event < ActiveRecord::Base
  serialize :payload, JSON
  belongs_to :host_execution

  validates :event_type, presence: true
  validates :host_execution, presence: true
end
