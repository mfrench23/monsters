require 'test_helper'

class RpmRitualModifierTest < ActiveSupport::TestCase
  test "string versions" do
    campaign = FactoryGirl.create(:campaign)
    subtype = FactoryGirl.create(:rpm_modifier_subtype, :multiplier => 1.5, :name => "Variable")
    mod = FactoryGirl.create(:rpm_modifier, :campaign => campaign)
    level = FactoryGirl.create(:rpm_modifier_level, :campaign => campaign, :rpm_modifier => mod)
    ritual = FactoryGirl.create(:rpm_ritual, :campaign => campaign)
    ritual_mod = RpmRitualModifier.new(:rpm_modifier_level => level, :rpm_ritual => ritual, :rpm_modifier_subtype => subtype )
    # vanilla modifier, with no enhancements
    assert_equal "Fnordian Strength Variable ST 10 (15)", ritual_mod.to_long_s
    # with enhancements, where cost < 20
    ritual_mod.enhancement_percentage = 25
    ritual_mod.enhancement_notes = "Piercing, +25%"
    assert_equal "Fnordian Strength Variable ST 10 (Piercing, +25%) (20)", ritual_mod.to_long_s
    # with enhancements, where cost > 20
    level.cost = 100
    level.save!
    assert_equal "Fnordian Strength Variable ST 10 (Piercing, +25%) (188)", ritual_mod.to_long_s
  end
end
