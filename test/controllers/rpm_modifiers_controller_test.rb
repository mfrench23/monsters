require 'test_helper'

class RpmModifiersControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    cookies[:selected_campaign] = @campaign.id.to_s
    @rpm_modifier = FactoryBot.create(:rpm_modifier, :campaign => @campaign)
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

  test "should create rpm_modifier" do
    name = "Ectoplasm Production"
    assert_difference('RpmModifier.count') do
      post :create, params: { rpm_modifier: { campaign_id: @rpm_modifier.campaign_id, name: name } }
    end

    assert_response :found
    rpm_modifier = RpmModifier.where(:name => name).order("created_at desc").first
    assert_not_nil rpm_modifier
    assert_redirected_to rpm_modifier
  end

  test "should show rpm_modifier" do
    get :show, params: { id: @rpm_modifier }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @rpm_modifier }
    assert_response :success
  end

  test "should update rpm_modifier" do
    patch :update, params: { id: @rpm_modifier, rpm_modifier: { campaign_id: @rpm_modifier.campaign_id, name: @rpm_modifier.name, notes: @rpm_modifier.notes } }
    assert_redirected_to @rpm_modifier
  end

  test "should destroy rpm_modifier" do
    @request.env['HTTP_REFERER'] = rpm_modifiers_path
    assert_difference('RpmModifier.count', -1) do
      delete :destroy, params: { id: @rpm_modifier }
    end
    assert_redirected_to rpm_modifiers_path
  end
end
