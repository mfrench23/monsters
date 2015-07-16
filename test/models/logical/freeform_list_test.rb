require 'test_helper'

class FreeformListTest < ActiveSupport::TestCase
  setup do
  end

  test "merges newlines" do
    list = Logical::FreeformList.new("a\nb\nc(1;2)").list
    assert_equal 1, list.count
    assert_equal "abc(1;2)", list.first
  end

  test "breaks on delimiters outside parens" do
    list = Logical::FreeformList.new("a(1;2), b; c").list
    assert_equal 3, list.count
    assert_equal "a(1;2)", list.first
    assert_equal "b", list.second.strip
    assert_equal "c", list.third.strip
  end
end
