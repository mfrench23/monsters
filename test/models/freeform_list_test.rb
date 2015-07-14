require 'test_helper'

class FreeformListTest < ActiveSupport::TestCase
  setup do
  end

  test "merges newlines" do
    list = FreeformList.new("a\nb\nc(1;2)").freeform_break
    assert_equal 1, list.count
    assert_equal "abc(1;2)", list.first
  end

  test "breaks on delimiters outside parens" do
    list = FreeformList.new("a(1;2), b; c").freeform_break
    assert_equal 3, list.count
    assert_equal "a(1;2)", list.first
    assert_equal "b", list.second.strip
    assert_equal "c", list.third.strip
  end
end
