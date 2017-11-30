require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    cookies[:selected_campaign] = @campaign.id.to_s
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get no randomized equipment without random_eq_profile definitions" do
    @request.env['HTTP_REFERER'] = campaigns_path
    get :randomize
    assert_response :found
  end

  test "should create campaign" do
    assert_difference('Campaign.count') do
      post :create, params: { campaign: { name: @campaign.name + " Part 2" } }
    end

    assert_response :found
    campaign = Campaign.where(:name => @campaign.name + " Part 2" ).order("created_at desc").first
    assert_not_nil campaign
    assert_redirected_to campaign
  end

  test "should fail to create" do
    assert_no_difference('Campaign.count') do
      post :create, params: { campaign: { name: nil } }
    end

    assert_response 200
  end

  test "should show campaign" do
    get :show, params: { id: @campaign }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @campaign }
    assert_response :success
    assert_select "label", {:text => "Name"}
  end

  test "should update campaign" do
    patch :update, params: { id: @campaign, campaign: { name: @campaign.name + " Renamed" } }
    assert_redirected_to @campaign
  end

  test "should fail to update" do
    patch :update, params: { id: @campaign, campaign: { name: nil } }
    assert_response 200
  end

  test "should destroy campaign" do
    @request.env['HTTP_REFERER'] = campaigns_path
    assert_difference('Campaign.count', -1) do
      delete :destroy, params: { id: @campaign }
    end

    assert_redirected_to campaigns_path
  end

  test "should set selected campaign" do
    get :set_selected_campaign, params: { campaign_id: @campaign.id }
    assert_equal @campaign.id.to_s, cookies[:selected_campaign] #starts as nil
  end
end
