json.array!(@hosts) do |host|
  json.extract! host, :id, :name
  json.url host_url(host, format: :json)
end
