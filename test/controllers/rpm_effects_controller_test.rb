require 'test_helper'

class RpmEffectsControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    cookies[:selected_campaign] = @campaign.id.to_s
    @rpm_effect = FactoryBot.create(:rpm_effect, campaign: @campaign)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rpm_effect" do
    name = "Modify"
    assert_difference('RpmEffect.count') do
      post :create, params: { rpm_effect: { campaign_id: @rpm_effect.campaign_id, cost: @rpm_effect.cost, name: name, notes: @rpm_effect.notes } }
    end

    assert_response :found
    rpm_effect = RpmEffect.where(:name => name).order("created_at desc").first
    assert_not_nil rpm_effect
    assert_redirected_to rpm_effect
  end

  test "should show rpm_effect" do
    get :show, params: { id: @rpm_effect }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @rpm_effect }
    assert_response :success
  end

  test "should update rpm_effect" do
    patch :update, params: { id: @rpm_effect, rpm_effect: { name: @rpm_effect.name + "-2", notes: "Noted." } }
    assert_redirected_to @rpm_effect
  end

  test "should destroy rpm_effect" do
    @request.env['HTTP_REFERER'] = rpm_effects_path
    assert_difference('RpmEffect.count', -1) do
      delete :destroy, params: { id: @rpm_effect }
    end
    assert_redirected_to rpm_effects_path
  end
end
