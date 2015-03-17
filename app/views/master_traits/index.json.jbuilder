json.array!(@master_traits) do |master_trait|
  json.extract! master_trait, :id, :name, :notes, :is_feature
  json.url master_trait_url(master_trait, format: :json)
end
