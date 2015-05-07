json.array!(@plans) do |plan|
  json.extract! plan, :id, :revision_id, :status, :is_dry_run
  json.url plan_url(plan, format: :json)
end
