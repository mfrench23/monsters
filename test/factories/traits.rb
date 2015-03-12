FactoryGirl.define do
  factory :trait do
    name "Catlike Reflexes"
  end
  factory :cannot_swim, class: Trait do
    name "Cannot Swim"
    is_feature true
  end
end
