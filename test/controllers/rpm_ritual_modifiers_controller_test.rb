require 'test_helper'

class RpmRitualModifiersControllerTest < ActionController::TestCase
  test "should get show" do
    campaign = FactoryGirl.create(:campaign)
    cookies[:selected_campaign] = campaign.id.to_s
    mod = RpmModifier.new(:name => "Extra Energy", :campaign => campaign)
    mod.save!
    get :show, :id => mod.id, :format => :json
    assert_response :success
  end
end
