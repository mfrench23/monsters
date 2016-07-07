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
    roll = @service.roll("20d3")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (20 <= roll && roll <= 60), roll
  end

  test "can add" do
    roll = @service.roll("1d+6")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (7 <= roll && roll <= 12), roll
    roll = @service.roll("1d+106")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (107 <= roll && roll <= 112), roll
  end

  test "can subtract" do
    roll = @service.roll("1d-3")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (-2 <= roll && roll <= 4), roll
    roll = @service.roll("1d-13")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, (-12 <= roll && roll <= -7), roll
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
    roll = @service.roll("1d*30")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, [30,60,90,120,150,180].include?(roll), roll
  end

  test "can perform integer division" do
    roll = @service.roll("1d/2")
    assert_not_nil roll
    assert_equal roll.to_i, roll
    assert_equal true, [1,2,3].include?(roll), roll
    roll = @service.roll("10/2")
    assert_equal 5, roll
  end

  test "respects parens" do
    roll = @service.roll("3*(1+4)")
    assert_equal 15, roll
    roll = @service.roll("3*(1+2*(1+1))")
    assert_equal 15, roll
  end
end
