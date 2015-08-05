require 'test_helper'

class MonstersHelperTest < ActionView::TestCase
  test "toggle_links returns two links, one hidden, one visible" do
    result = toggle_links("meta")
    assert_equal 2, result.scan(/<a/).count
    assert_equal 1, result.scan(/display: none"><a/).count
    assert_equal 1, result.scan(/display: inline-block"><a/).count
  end
end