require 'test_helper'

class ManyToManyCheckboxTableHelperTest < ActionView::TestCase
  test "displays subheaders" do
    assert_match /<span.*>\(n\/a\).*<\/span>/, display_subheader("")
    assert_equal "<span>Stuff</span>", display_subheader("Stuff")
  end
end