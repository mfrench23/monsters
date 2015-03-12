require 'test_helper'

class DamageResistancesHelperTest < ActionView::TestCase
  setup do
    @one = damage_resistances(:one)
    @two = damage_resistances(:two)
  end
  
  test "should format correctly" do
    assert_equal "Head: 1", simpleDR(@one)
    assert_equal "Tail: 2 (flexible)", simpleDR(@two)
  end
end