require 'test_helper'

class RandomEqProfileLineItemTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.create(:random_eq_profile_line_item)
  end

  test "to_s" do
    assert_equal "1 Related to Feng Shui", @one.to_s
  end

  test "complains if over-loaded with modifiers" do
    cat = FactoryGirl.create(:equipment_modifier_category)
    @one.equipment_modifier_category = cat
    assert_equal false, @one.valid?
  end
end
