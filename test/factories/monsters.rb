FactoryGirl.define do
  factory :monster do
    name "Tim the Test Monster"
    monster_class {MonsterClass.find_by(name: "Undead")}
    characteristic_monsters { [FactoryGirl.build(:characteristic_monster)] }
  end
end

