require 'test_helper'

class RpmRitualVariantsControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    @rpm_ritual = FactoryBot.create(:rpm_ritual, :campaign => @campaign)
  end

  test "should create rpm_ritual_variant, then fail due to duplicate names" do
    name = "Long-term version"
    assert_difference('RpmRitualVariant.count') do
      post :create, params: { rpm_ritual_variant: { name: name, rpm_ritual_id: @rpm_ritual.id } }
    end

    assert_response :found
    rpm_ritual_variant = RpmRitualVariant.order("created_at desc").first
    assert_not_nil rpm_ritual_variant
    assert_redirected_to rpm_ritual_variant.rpm_ritual
    assert_equal "Variant was successfully created.", flash[:notice]
    
    assert_no_difference('RpmRitualVariant.count') do
      post :create, params: { rpm_ritual_variant: { name: name, rpm_ritual_id: @rpm_ritual.id } }
    end
    assert_redirected_to rpm_ritual_variant.rpm_ritual
    assert_equal "Variant was NOT successfully created.", flash[:notice]
  end
end
