json.array!(@logs) do |log|
  json.extract! log, :id, :host, :status, :file_path
  json.url log_url(log, format: :json)
end
