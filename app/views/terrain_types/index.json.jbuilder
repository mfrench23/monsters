json.array!(@terrain_types) do |terrain_type|
  json.extract! terrain_type, :id, :name
  json.url terrain_type_url(terrain_type, format: :json)
end
