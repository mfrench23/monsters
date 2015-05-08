require 'test_helper'

class CharacteristicTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:characteristic, :step_size => 1.0)
    @two = FactoryGirl.build(:characteristic, :step_size => 0.5)
  end

  test "normalizes 1.0 to 1" do
    assert_equal 1, @one.normalize(1.0)
  end

  test "normalizes 1.2 to 1" do
    assert_equal 1, @one.normalize(1.2)
  end

  test "normalizes 1.7 to 1" do
    assert_equal 1, @one.normalize(1.7)
  end

  test "normalizes 1.0 to 1.0" do
    assert_equal 1.0, @two.normalize(1.0)
  end

  test "normalizes 1.5 to 1.5" do
    assert_equal 1.5, @two.normalize(1.5)
  end

  test "normalizes 1.25 to 1.0" do
    assert_equal 1.0, @two.normalize(1.25)
  end
end
