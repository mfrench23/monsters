FactoryGirl.define do
  factory :skill do
    modifier 1
    association :master_skill
  end
end
