json.array!(@traits) do |trait|
  json.extract! trait, :id, :monster_id, :name, :description, :is_feature, :level
  json.url trait_url(trait, format: :json)
end
