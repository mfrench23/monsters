json.array!(@master_skills) do |master_skill|
  json.extract! master_skill, :id, :name, :baseStat, :notes
  json.url master_skill_url(master_skill, format: :json)
end