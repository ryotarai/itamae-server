json.array!(@revisions) do |revision|
  json.extract! revision, :id, :name, :tar_url
  json.url revision_url(revision, format: :json)
end
