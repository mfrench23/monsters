FactoryBot.define do
  factory :rpm_modifier_level do
    description {"ST 10"}
    cost {10}
    include_notes_in_summary {true}
    accepts_enhancements {true}
  end
end
