FactoryGirl.define do
  factory :damage_resistance do
    location { Location.find_by(name: "skull") }
    dr 1
  end
end
