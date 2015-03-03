json.array!(@damage_resistances) do |damage_resistance|
  json.extract! damage_resistance, :id, :monster_id, :location_id, :dr, :notes
  json.url damage_resistance_url(damage_resistance, format: :json)
end
