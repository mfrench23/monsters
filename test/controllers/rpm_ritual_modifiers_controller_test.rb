require 'test_helper'

class RpmRitualModifiersControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryGirl.create(:campaign)
    cookies[:selected_campaign] = @campaign.id.to_s
    @mod = RpmModifier.new(:name => "Extra Energy", :campaign => @campaign)
    @mod.save!
  end

  test "should get levels" do
    get :levels, :id => @mod.id, :format => :json
    assert_response :success
  end

  test "should get subtypes" do
    get :subtypes, :id => @mod.id, :format => :json
    assert_response :success
  end
end
