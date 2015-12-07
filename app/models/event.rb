class Event < ActiveRecord::Base
  serialize :payload, JSON
  belongs_to :execution
  belongs_to :host

  validates :event_type, presence: true
  validates :execution, presence: true
  validates :host, presence: true
end
