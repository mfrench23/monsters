require 'test_helper'

class EquipmentTypeMassEntryFormTest < ActionView::TestCase
  test "should detect trouble with the input" do
    form = get_form("Bad input")
    assert_equal false, form.ok?
    assert_equal true, form.error_messages.count > 0
  end

  test "should detect acceptable input" do
    form = get_form("Crazy Test Weapon with spikes ($100; 11#)\nAnother weapon ($5; 1#)\n\n")
    assert_equal 2, form.equipment_types.count
    assert_equal true, form.error_messages.empty?
    assert_equal true, form.ok?
  end

  def get_form(text)
    campaign = FactoryGirl.create(:campaign)
    params = ActionController::Parameters.new({:equipment_category_name => "Silly Test Stuff " + Time.now.to_f.to_s,
                                          :campaign_id => campaign.id,
                                          :freeform_text => text})
    EquipmentTypeMassEntryForm.new(params)
  end
end
