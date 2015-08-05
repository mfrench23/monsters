require 'test_helper'

class CampaignContentTest < ActiveSupport::TestCase
  test "deep_copy" do
    campaign = FactoryGirl.create(:campaign)
    cc = CampaignContent.new(:id => 7, :campaign => campaign)
    copy = cc.deep_copy
    assert_nil copy.id
    assert_equal campaign, copy.campaign
  end
end
