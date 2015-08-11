require 'test_helper'

class EquipmentTypeTest < ActiveSupport::TestCase
  setup do
    @equipment_category = FactoryGirl.create(:equipment_category)
  end

  test "should parse bad input as an invalid instance" do
    eq = EquipmentType.parse("Big rock (150#)", @equipment_category.id)
    assert_not_nil eq
    eq.validate
    assert_equal false, eq.valid?
  end

  test "should parse prices with commas and cents and fractional weight" do
    eq = EquipmentType.parse("Big rock ($2,000.25; 150.5#)", @equipment_category.id)
    assert_not_nil eq
    assert_equal "2000.25", eq.base_cost.to_s
    assert_equal "150.5", "%g" % eq.base_weight.to_s
    assert_equal true, eq.valid?
    assert_equal @equipment_category.id.to_s, eq.equipment_category_id.to_s
  end
end
