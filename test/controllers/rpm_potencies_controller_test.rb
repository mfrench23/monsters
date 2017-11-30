require 'test_helper'

class RpmPotenciesControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    cookies[:selected_campaign] = @campaign.id.to_s
    @rpm_potency = FactoryBot.create(:rpm_potency, :campaign => @campaign)
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

  test "should create rpm_potency" do
    name = "Cosmic IV"
    assert_difference('RpmPotency.count') do
      post :create, params: { rpm_potency: { campaign_id: @rpm_potency.campaign_id, name: name } }
    end

    assert_response :found
    rpm_potency = RpmPotency.where(:name => name).order("created_at desc").first
    assert_not_nil rpm_potency
    assert_redirected_to rpm_potency
  end

  test "should show rpm_potency" do
    get :show, params: { id: @rpm_potency }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @rpm_potency }
    assert_response :success
  end

  test "should update rpm_potency" do
    patch :update, params: { id: @rpm_potency, rpm_potency: { campaign_id: @rpm_potency.campaign_id, name: @rpm_potency.name, notes: @rpm_potency.notes } }
    assert_redirected_to @rpm_potency
  end

  test "should destroy rpm_potency" do
    @request.env['HTTP_REFERER'] = rpm_potencies_path
    assert_difference('RpmPotency.count', -1) do
      delete :destroy, params: { id: @rpm_potency }
    end
    assert_redirected_to rpm_potencies_path
  end
end
