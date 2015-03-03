json.array!(@monsters) do |monster|
  json.extract! monster, :id, :strength, :dexterity, :intelligence, :health, :hitPoints, :will, :perception, :fatigue, :speed, :sizeModifier, :height, :weight, :gear, :description, :notes, :dodge, :block
  json.url monster_url(monster, format: :json)
end
