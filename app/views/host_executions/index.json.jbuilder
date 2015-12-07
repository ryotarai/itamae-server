json.array!(@host_executions) do |host_execution|
  json.extract! host_execution, :id, :host_id, :execution_id
  json.url host_execution_url(host_execution, format: :json)
end
