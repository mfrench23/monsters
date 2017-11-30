FactoryGirl.define do
  factory :creature, parent: :monster, class: 'Creature' do
    height "6 ft 2 in"
    weight "180 lbs."
    parts_value_cents 100
  end

end
