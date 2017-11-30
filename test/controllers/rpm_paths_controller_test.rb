require 'test_helper'

class RpmPathsControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    cookies[:selected_campaign] = @campaign.id.to_s
    @rpm_path = FactoryBot.create(:rpm_path, campaign: @campaign)
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

  test "should create rpm_path" do
    name = @rpm_path.name + "-2"
    assert_difference('RpmPath.count') do
      post :create, params: { rpm_path: { campaign_id: @rpm_path.campaign_id, name: name, notes: @rpm_path.notes } }
    end

    assert_response :found
    rpm_path = RpmPath.where(:name => name).order("created_at desc").first
    assert_not_nil rpm_path
    assert_redirected_to rpm_path
  end

  test "should show rpm_path" do
    get :show, params: { id: @rpm_path }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @rpm_path }
    assert_response :success
  end

  test "should update rpm_path" do
    patch :update, params: { id: @rpm_path, rpm_path: { campaign_id: @rpm_path.campaign_id, name: @rpm_path.name, notes: @rpm_path.notes } }
    assert_redirected_to @rpm_path
  end

  test "should destroy rpm_path" do
    @request.env['HTTP_REFERER'] = rpm_paths_path
    assert_difference('RpmPath.count', -1) do
      delete :destroy, params: { id: @rpm_path }
    end
    assert_redirected_to rpm_paths_path
  end
end
