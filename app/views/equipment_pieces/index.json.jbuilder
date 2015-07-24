json.array!(@equipment_pieces) do |equipment_piece|
  json.extract! equipment_piece, :id, :equipment_type_id
  json.url equipment_piece_url(equipment_piece, format: :json)
end
