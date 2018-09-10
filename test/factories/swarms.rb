FactoryBot.define do
  factory :swarm, parent: :monster, class: 'Swarm' do
    number_description { "several dozen" }
  end
end
