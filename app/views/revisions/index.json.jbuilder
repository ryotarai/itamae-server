json.array!(@revisions) do |revision|
  json.extract! revision, :id, :name, :url
  json.url revision_url(revision, format: :json)
end
