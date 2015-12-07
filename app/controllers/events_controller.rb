class EventsController < ApplicationController
  def bulk_create
    execution = Execution.find(params[:execution_id])

    events = params['events']
    unless events
      render_error("events field is required", 400) and return
    end

    host = params['host']
    unless host
      render_error("host field is required", 400) and return
    end

    host = Host.find_or_create_by(name: host)
    events = events.map do |event|
      Event.new(host: host, execution: execution, event_type: event['type'], payload: event['payload'])
    end
    result = Event.import(events, validate: true)

    render json: {"rows_created" => result.num_inserts}, status: 201
  end
end
