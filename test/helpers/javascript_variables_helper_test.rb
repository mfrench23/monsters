require 'test_helper'

class JavascriptVariablesHelperTest < ActionView::TestCase
  test "should set up JS variables" do
    hash = { :stuff => "things"}
    assert_equal "var stuff = \"things\";", javascript_variables(hash)
  end
end