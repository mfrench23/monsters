json.array!(@attacks) do |attack|
  json.extract! attack, :id, :monster_id, :name, :skill, :description
  json.url attack_url(attack, format: :json)
end
