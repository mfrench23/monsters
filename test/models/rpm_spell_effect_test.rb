require 'test_helper'

class RpmSpellEffectTest < ActiveSupport::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    @pot = FactoryBot.create(:rpm_potency, :campaign => @campaign)
    @eff = FactoryBot.create(:rpm_effect, :campaign => @campaign, :cost => 5)
    @path = FactoryBot.create(:rpm_path, :campaign => @campaign)
    @spell_effect = RpmSpellEffect.new(:rpm_potency => @pot, :rpm_effect => @eff, :rpm_path => @path)
  end

  test "to-string methods and deep copy" do
    assert_equal "Younger Move Cheese", @spell_effect.to_short_s
    assert_equal "Younger Move Cheese (5)", @spell_effect.to_long_s
    assert_equal "Younger Move Cheese (5)", @spell_effect.deep_copy.to_long_s
  end
end
