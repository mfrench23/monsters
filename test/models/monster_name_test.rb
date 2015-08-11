require 'test_helper'

class MonsterNameTest < ActiveSupport::TestCase
  setup do
  end

  test "comparison" do
    @one = MonsterName.new(:name => "Bob")
    @two = MonsterName.new(:name => "Don")
    @three = MonsterName.new(:name => "Zed")

    assert_equal nil, @one <=> "Fish"
    assert_equal nil, "Fish" <=> @one
    assert_equal 0, @one <=> @one
    assert_equal -1, @one <=> @two
    assert_equal 1, @two <=> @one
    assert_equal 1, @three <=> @two
  end
end
