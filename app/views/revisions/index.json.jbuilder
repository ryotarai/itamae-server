json.array!(@revisions) do |revision|
  json.extract! revision, :id
  json.url revision_url(revision, format: :json)
end
