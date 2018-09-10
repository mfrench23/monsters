FactoryBot.define do
  factory :random_eq_profile_line_item do
    quantity {1}
    association :equipment_modifier_supercategory
  end
end
