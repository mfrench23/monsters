require 'test_helper'

class RpmRitualGridServiceTest < ActionView::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    @pot = FactoryBot.create(:rpm_potency, :campaign => @campaign)
    @eff = FactoryBot.create(:rpm_effect, :campaign => @campaign, :cost => 5)
    @path = FactoryBot.create(:rpm_path, :campaign => @campaign)
    @service = RpmRitualGridService.new
  end

  test "grid" do
    grid = @service.grid(@campaign.id)
    assert_equal 1, grid.count # 1 path
    assert_equal 1, grid[grid.keys.first].count, grid # with 1 effect
    assert_equal 1, grid[grid.keys.first][grid[grid.keys.first].keys.first].count # at 1 potency
    FactoryBot.create(:rpm_path, :campaign => @campaign, :name => "Path of Mummies")
    grid = @service.grid(@campaign.id)
    assert_equal 2, grid.count # for 2 paths
  end
end
