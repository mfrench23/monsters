FactoryGirl.define do
  factory :characteristic_monster do
    characteristic {FactoryGirl.build(:characteristic)}
    score 10
  end

end
