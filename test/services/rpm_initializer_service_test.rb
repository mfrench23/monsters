require 'test_helper'

class RpmInitializerServiceTest < ActionView::TestCase
  setup do
    @service = RpmInitializerService.new
  end

  test "performs standard setup on campaign once and only once" do
    campaign = FactoryBot.create(:campaign, :name => "Blank Campaign 1")
    assert_difference( "RpmPath.where(:campaign_id => #{campaign.id}).count", 9) do
      @service.standardize(campaign.id)
    end
    assert_no_difference( "RpmPath.where(:campaign_id => #{campaign.id}).count") do
      @service.standardize(campaign.id)
    end
  end
end
