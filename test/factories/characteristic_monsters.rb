FactoryGirl.define do
  factory :characteristic_monster do
    characteristic { Characteristic.find_by(name: "DX") }
    score 10
  end

end
