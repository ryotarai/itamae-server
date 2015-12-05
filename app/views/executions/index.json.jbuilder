json.array!(@executions) do |execution|
  json.extract! execution, :id, :revision_id
  json.url execution_url(execution, format: :json)
end
