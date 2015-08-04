require 'test_helper'

class EquipmentCategoryTest < ActiveSupport::TestCase
  test "cannot save without a name of 2 or more characters" do
    eq = EquipmentCategory.new(:name => nil)
    assert_equal false, eq.save
    eq.name = "A"
    assert_equal false, eq.save
    eq.name = "IT"
    assert_equal true, eq.save
  end
end
