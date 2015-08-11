require 'test_helper'

class CharacteristicTest < ActiveSupport::TestCase
  setup do
  end

  test "normalizes" do
    one = Characteristic.new(:step_size => 1.0)
    two = Characteristic.new(:step_size => 0.5)
    assert_equal 1, one.normalize(1.0)
    assert_equal 1, one.normalize(1.2)
    assert_equal 1, one.normalize(1.7)
    assert_equal 1.0, two.normalize(1.0)
    assert_equal 1.5, two.normalize(1.5)
    assert_equal 1.0, two.normalize(1.25)
  end
end
