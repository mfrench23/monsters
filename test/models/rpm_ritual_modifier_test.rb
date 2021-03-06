require 'test_helper'

class RpmRitualModifierTest < ActiveSupport::TestCase
  test "string versions and deep_copy" do
    campaign = FactoryBot.create(:campaign)
    subtype = FactoryBot.create(:rpm_modifier_subtype, :multiplier => 1.5, :name => "Variable")
    mod = FactoryBot.create(:rpm_modifier, :campaign => campaign)
    level = FactoryBot.create(:rpm_modifier_level, :campaign => campaign, :rpm_modifier => mod)
    ritual = FactoryBot.create(:rpm_ritual, :campaign => campaign)
    ritual_mod = RpmRitualModifier.new(:rpm_modifier_level => level, :rpm_ritual => ritual, :rpm_modifier_subtype => subtype )
    # vanilla modifier, with no enhancements
    assert_equal "Fnordian Strength, Variable ST 10 (15)", ritual_mod.to_long_s
    assert_equal "Fnordian Strength, Variable", ritual_mod.to_short_s
    # with enhancements, where cost < 20
    ritual_mod.enhancement_notes = "Piercing, +25%"
    ritual_mod.enhancement_percentage = 0
    assert_equal "Fnordian Strength, Variable ST 10 (Piercing, +25%) (16)", ritual_mod.to_long_s
    assert_equal "Fnordian Strength, Variable (Piercing, +25%)", ritual_mod.to_short_s
    ritual_mod.enhancement_percentage = 25
    assert_equal "Fnordian Strength, Variable ST 10 (Piercing, +25%) (20)", ritual_mod.to_long_s
    # with enhancements, where cost > 20
    level.cost = 100
    level.save!
    assert_equal "Fnordian Strength, Variable ST 10 (Piercing, +25%) (188)", ritual_mod.to_long_s
    # "enhancement only" pricing
    ritual_mod.enhancement_only = true
    assert_equal "Fnordian Strength, Variable ST 10 (Piercing, +25%), enhancement only (38)", ritual_mod.to_long_s
    assert_equal "Fnordian Strength, Variable ST 10 (Piercing, +25%), enhancement only (38)", ritual_mod.deep_copy.to_long_s
    # with an enhancement of 0%
    ritual_mod.enhancement_percentage = 0
    assert_equal "Fnordian Strength, Variable ST 10 (Piercing, +25%), enhancement only (1)", ritual_mod.to_long_s
    ritual_mod.enhancement_only = false
    assert_equal "Fnordian Strength, Variable ST 10 (Piercing, +25%) (151)", ritual_mod.to_long_s
    assert_equal "Fnordian Strength, Variable ST 10 (Piercing, +25%) (151)", ritual_mod.deep_copy.to_long_s
    assert_equal "Fnordian Strength, Variable (Piercing, +25%)", ritual_mod.to_short_s
  end
end
