json.array!(@monster_names) do |monster_name|
  json.extract! monster_name, :id, :monster_id, :primary, :name, :notes
  json.url monster_name_url(monster_name, format: :json)
end
