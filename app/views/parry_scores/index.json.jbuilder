json.array!(@parry_scores) do |parry_score|
  json.extract! parry_score, :id, :weapon, :parry
  json.url parry_score_url(parry_score, format: :json)
end
