FactoryBot.define do
  factory :rpm_ritual_modifier do
    association :rpm_ritual
    association :rpm_modifier_level
    notes "Quite profane."
    enhancement_percentage 52
  end
end
