require 'test_helper'

class RpmRitualsControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryGirl.create(:campaign)
    cookies[:selected_campaign] = @campaign.id.to_s
    @rpm_ritual = FactoryGirl.create(:rpm_ritual, :campaign => @campaign)
  end

  test "should get pdf" do
    get :full_book, :format => "pdf"
    assert_response :success
  end

  test "should set up static data for standard RPM" do
    get :standard_rpm
    assert_response :found
    assert_redirected_to new_rpm_ritual_path
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get grid" do
    get :grid
    assert_response :success
    assert_select "table", 0 # no table, just a warning that there's no data
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get duplicate" do
    get :duplicate, id: @rpm_ritual
    assert_response :success
    assert_select "#rpm_ritual_name[value=?]", @rpm_ritual.name # Expecting input box to be populated from starting ritual
  end

  test "should create rpm_ritual" do
    name = "Other Banishing Ritual of the Fnord"
    assert_difference('RpmRitual.count') do
      post :create, rpm_ritual: { campaign_id: @rpm_ritual.campaign_id, name: name, typical_cost: @rpm_ritual.typical_cost }
    end

    assert_response :found
    rpm_ritual = RpmRitual.where(:name => name).order("created_at desc").first
    assert_not_nil rpm_ritual
    assert_redirected_to rpm_ritual
  end

  test "should show rpm_ritual" do
    get :show, id: @rpm_ritual
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rpm_ritual
    assert_response :success
  end

  test "should update rpm_ritual" do
    patch :update, id: @rpm_ritual, rpm_ritual: { campaign_id: @rpm_ritual.campaign_id, description: @rpm_ritual.description, name: @rpm_ritual.name, typical_cost: @rpm_ritual.typical_cost }
    assert_redirected_to @rpm_ritual
  end

  test "should destroy rpm_ritual" do
    @request.env['HTTP_REFERER'] = rpm_rituals_path
    assert_difference('RpmRitual.count', -1) do
      delete :destroy, id: @rpm_ritual
    end
    assert_redirected_to rpm_rituals_path
  end
end
