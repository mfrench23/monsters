FactoryGirl.define do
  factory :rpm_spell_effect do
    rpm_ritual nil
    rpm_potency nil
    rpm_effect nil
    rpm_path nil
    notes "MyText"
    inherent false
  end
end
