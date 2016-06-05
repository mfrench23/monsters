require 'test_helper'

class MonstersHelperTest < ActionView::TestCase
  test "toggle_links returns two links, one hidden, one visible, with data-toggle_id set" do
    result = toggle_links("meta")
    assert_equal 2, result.scan(/<a/).count
    assert_equal 1, result.scan(/display: none" data-toggle_id="meta"><a/).count
    assert_equal 1, result.scan(/display: inline-block" data-toggle_id="meta"><a/).count
  end
end