require 'test_helper'

class RandomEquipmentServiceSimpleTest < ActionView::TestCase
  setup do
    @service = RandomEquipmentService.new
  end

  test "should return nil if given nil" do
    assert_nil @service.randomize(nil)
  end

  test "should return nil if given something it can't randomize" do
    assert_nil @service.randomize("Garbage in...")
  end
end
