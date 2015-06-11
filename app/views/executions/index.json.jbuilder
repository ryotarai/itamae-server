json.array!(@executions) do |execution|
  json.extract! execution, :id, :revision_id, :status, :is_dry_run
  json.url execution_url(execution, format: :json)
end
