json.array!(@equipment_types) do |equipment_type|
  json.extract! equipment_type, :id, :name, :base_weight, :base_cost_cents, :equipment_category_id, :notes
  json.url equipment_type_url(equipment_type, format: :json)
end
