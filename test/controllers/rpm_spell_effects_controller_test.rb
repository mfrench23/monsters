require 'test_helper'

class RpmSpellEffectsControllerTest < ActionController::TestCase
  setup do
    campaign = FactoryBot.create(:campaign)
    cookies[:selected_campaign] = campaign.id.to_s
    pot = FactoryBot.create(:rpm_potency, :campaign => campaign, :name => "Lesser")
    eff = FactoryBot.create(:rpm_effect, :campaign => campaign, :name => "Create")
    path = FactoryBot.create(:rpm_path, :campaign => campaign, :name => "Nachos")
    ritual = RpmRitual.new(:name => "Flying Pig Ritual", :campaign => campaign )
    @rpm_spell_effect = RpmSpellEffect.new( :rpm_potency => pot, :rpm_effect => eff, :rpm_path => path, :inherent => false)
    ritual.rpm_spell_effects << @rpm_spell_effect
    ritual.save!
  end

  test "should always get index, but contents only when spell effect is inherent" do
    get :index
    assert_response :success
    assert_select "table tbody tr", 0
    @rpm_spell_effect.inherent = true
    @rpm_spell_effect.save!
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end
end
