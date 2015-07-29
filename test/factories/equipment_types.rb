FactoryGirl.define do
  factory :equipment_type do
    name "Rather Narrow Sword"
    base_weight 9.99
    base_cost_cents 1000
    association :equipment_category
    notes nil
  end

end
