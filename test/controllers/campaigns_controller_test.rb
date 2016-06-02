require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryGirl.create(:campaign)
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

  test "should create campaign" do
    assert_difference('Campaign.count') do
      post :create, campaign: { name: @campaign.name + " Part 2" }
    end

    assert_response :found
    campaign = Campaign.where(:name => @campaign.name + " Part 2" ).order("created_at desc").first
    assert_not_nil campaign
    assert_redirected_to campaign
  end

  test "should fail to create" do
    assert_no_difference('Campaign.count') do
      post :create, campaign: { name: nil }
    end

    assert_response 200
  end

  test "should show campaign" do
    get :show, id: @campaign
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campaign
    assert_response :success
    assert_select "span", {:text => "Monsters"}
  end

  test "should update campaign" do
    patch :update, id: @campaign, campaign: { name: @campaign.name + " Renamed" }
    assert_redirected_to @campaign
  end

  test "should fail to update" do
    patch :update, id: @campaign, campaign: { name: nil }
    assert_response 200
  end

  test "should destroy campaign" do
    assert_difference('Campaign.count', -1) do
      delete :destroy, id: @campaign
    end

    assert_redirected_to campaigns_path
  end
end
