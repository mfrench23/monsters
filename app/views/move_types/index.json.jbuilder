json.array!(@move_types) do |move_type|
  json.extract! move_type, :id, :name
  json.url move_type_url(move_type, format: :json)
end
