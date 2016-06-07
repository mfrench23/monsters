FactoryGirl.define do
  factory :equipment_modifier do
    name "Stupid-Fine"
    base_cost_mod "x2"
    base_weight_mod "x0.75"
    cost_mod nil
    weight_mod nil
    association :equipment_modifier_category
  end

end
