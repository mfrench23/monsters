FactoryGirl.define do
  factory :damage_resistance do
    monster
    location
    dr 1
  end
  factory :damage_resistance_2, class: DamageResistance do
    monster
    association :location, name: "Tail"
    dr 2
    notes "Flexible"
  end
end
