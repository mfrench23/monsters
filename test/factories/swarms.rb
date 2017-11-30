FactoryBot.define do
  factory :swarm do
    number_description "several dozen"
    monster { FactoryBot.create(:monster) }
  end

end
