json.array!(@movement_rates) do |movement_rate|
  json.extract! movement_rate, :id, :monster_id, :terrain_type_id, :rate
  json.url movement_rate_url(movement_rate, format: :json)
end
