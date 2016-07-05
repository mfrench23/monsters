require 'test_helper'

class DieRollServiceTest < ActionView::TestCase
  setup do
    @service = DieRollService.new
  end

  test "should return 0 if given something it can't roll" do
    assert_equal 0, @service.roll(nil)
    assert_equal 0, @service.roll("Garbage in...")
  end

  test "should return min if roll is too low" do
    assert_equal 37, @service.roll("1d", 37)
  end

  test "returns numbers as integers" do
    assert_equal 1, @service.roll("1")
    assert_equal 7, @service.roll("7")
  end

  test "can roll simple dice" do
    roll = @service.roll("1d")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (1 <= roll && roll <= 6), roll
  end

  test "can roll simple dice of any size" do
    roll = @service.roll("d4")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (1 <= roll && roll <= 4), roll
  end

  test "can add" do
    roll = @service.roll("1d+6")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (7 <= roll && roll <= 12), roll
  end

  test "can subtract" do
    roll = @service.roll("1d-3")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (-2 <= roll && roll <= 4), roll
  end

  test "can add dice" do
    roll = @service.roll("1d+1d4")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (2 <= roll && roll <= 10), roll
  end

  test "can multiply" do
    roll = @service.roll("1d*3")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, [3,6,9,12,15,18].include?(roll), roll
  end

  test "can perform integer division" do
    roll = @service.roll("1d/2")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, [1,2,3].include?(roll), roll
  end
end
