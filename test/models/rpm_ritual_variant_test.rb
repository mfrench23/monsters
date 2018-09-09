require 'test_helper'

class RpmRitualVariantTest < ActiveSupport::TestCase
  test "variant from ritual and deep copy" do
    campaign = FactoryBot.create(:campaign)
    level = FactoryBot.create(:rpm_modifier_level)
    ritual = RpmRitual.new(:name => "Raise Spooky Doll", :campaign => campaign)
    ritual.rpm_ritual_modifiers << RpmRitualModifier.new(:rpm_modifier_level => level, :inherent => false)
    ritual.save!
    variant = RpmRitualVariant.from_ritual(ritual)
    assert_equal 1, variant.rpm_ritual_variant_modifiers.to_ary.count
    variant_mod = variant.rpm_ritual_variant_modifiers.first
    assert_equal level, variant_mod.rpm_modifier_level
    
    copy = variant.deep_copy
    assert_equal level, copy.rpm_ritual_variant_modifiers.first.rpm_modifier_level
    assert_not_equal variant_mod, copy.rpm_ritual_variant_modifiers.first
  end
end
