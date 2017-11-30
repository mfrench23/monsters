FactoryBot.define do
  factory :monster do
    sequence(:name) { |n| "Tim the Test Monster #{n}" }
    monster_class {MonsterClass.find_by(name: "Undead")}
    characteristic_monsters { [FactoryBot.build(:characteristic_monster)] }
    association :campaign
  end
end

