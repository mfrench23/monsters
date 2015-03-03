json.array!(@skills) do |skill|
  json.extract! skill, :id, :monster_id, :name, :trait, :modifier
  json.url skill_url(skill, format: :json)
end
