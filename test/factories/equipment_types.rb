FactoryGirl.define do
  factory :equipment_type do
    name "Rather Narrow Sword"
    base_weight 9.99
    base_cost_cents 1000
    notes nil
    random_weight 1
    association :equipment_category
    association :campaign
  end

end
