require 'test_helper'

class RpmRitualsHelperTest < ActionView::TestCase
  test "should combine duplicated spell effects into a single unit" do
    campaign = FactoryGirl.create(:campaign)
    pot = FactoryGirl.create(:rpm_potency, :campaign => campaign, :name => "Lesser")
    pot2 = FactoryGirl.create(:rpm_potency, :campaign => campaign, :name => "Greater")
    eff = FactoryGirl.create(:rpm_effect, :campaign => campaign, :name => "Create")
    eff2 = FactoryGirl.create(:rpm_effect, :campaign => campaign, :name => "Control")
    path = FactoryGirl.create(:rpm_path, :campaign => campaign, :name => "Nachos")
    rpm_ritual = RpmRitual.new(:name => "Flying Pig Ritual", :campaign => campaign )
    rpm_ritual.rpm_spell_effects << RpmSpellEffect.new(:rpm_potency => pot2, :rpm_effect => eff2, :rpm_path => path, :inherent => true)
    rpm_ritual.rpm_spell_effects << RpmSpellEffect.new(:rpm_potency => pot2, :rpm_effect => eff2, :rpm_path => path, :inherent => true)
    rpm_ritual.save!
    assert_equal "Greater Control Nachos x2", rpm_inherent_spell_effects_text(rpm_ritual)
    rpm_ritual.rpm_spell_effects << RpmSpellEffect.new(:rpm_potency => pot, :rpm_effect => eff, :rpm_path => path, :inherent => true)
    rpm_ritual.save!
    assert_equal "Greater Control Nachos x2 + Lesser Create Nachos", rpm_inherent_spell_effects_text(rpm_ritual)
    rpm_ritual.rpm_spell_effects << RpmSpellEffect.new(:rpm_potency => pot, :rpm_effect => eff, :rpm_path => path, :inherent => true)
    rpm_ritual.save!
    assert_equal "Greater Control Nachos x2 + Lesser Create Nachos x2", rpm_inherent_spell_effects_text(rpm_ritual)
    rpm_ritual.rpm_spell_effects << RpmSpellEffect.new(:rpm_potency => pot2, :rpm_effect => eff, :rpm_path => path, :inherent => true)
    rpm_ritual.save!
    assert_equal "Greater Control Nachos x2 + Greater Create Nachos + Lesser Create Nachos x2", rpm_inherent_spell_effects_text(rpm_ritual)
  end
end