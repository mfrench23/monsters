require 'test_helper'

class RandomEqProfileLineItemTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.create(:random_eq_profile_line_item)
  end

  test "to_s" do
    assert_equal "1 Related to Feng Shui", @one.to_s
  end
end
