class Event < ActiveRecord::Base
  serialize :payload, JSON
  belongs_to :host_execution

  validates :event_type, presence: true
  validates :host_execution, presence: true

  def self.group_by_action(events)
    result = []

    recipe = nil
    resource = nil

    events.each do |event|
      case event.event_type
      when 'recipe_started'
        recipe = event.payload
      when 'resource_started'
        resource = event.payload
      when 'action_started'
        result << OpenStruct.new(recipe: recipe, resource: resource, action: event.payload, events: [])
      when /_completed\z/, /_failed\z/
        # pass
      else
        result.last.events << event
      end
    end

    result
  end
end
