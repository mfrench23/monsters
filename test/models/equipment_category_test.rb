require 'test_helper'

class EquipmentCategoryTest < ActiveSupport::TestCase
  test "cannot save without a name of 2 or more characters" do
    campaign = FactoryBot.create(:campaign)
    eq = EquipmentCategory.new(:name => nil, :campaign => campaign)
    assert_equal false, eq.save
    eq.name = "A"
    assert_equal false, eq.save
    eq.name = "IT"
    assert_equal true, eq.save, eq.errors.reduce(""){|memo, err| memo += " " + err.to_s}
  end
end
