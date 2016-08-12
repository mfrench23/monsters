require 'test_helper'

class RpmSpellEffectTest < ActiveSupport::TestCase
  test "to-string methods" do
    campaign = FactoryGirl.create(:campaign)
    pot = FactoryGirl.create(:rpm_potency, :campaign => campaign)
    eff = FactoryGirl.create(:rpm_effect, :campaign => campaign, :cost => 5)
    path = FactoryGirl.create(:rpm_path, :campaign => campaign)
    spell_effect = RpmSpellEffect.new(:rpm_potency => pot, :rpm_effect => eff, :rpm_path => path)
    assert_equal "Younger Move Cheese", spell_effect.to_short_s
    assert_equal "Younger Move Cheese (5)", spell_effect.to_long_s
  end
end
