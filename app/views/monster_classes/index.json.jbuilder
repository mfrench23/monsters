json.array!(@monster_classes) do |monster_class|
  json.extract! monster_class, :id, :name
  json.url monster_class_url(monster_class, format: :json)
end
