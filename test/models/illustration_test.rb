require 'test_helper'

class IllustrationTest < ActiveSupport::TestCase
  test "deep_copy" do
    one = Illustration.new(:id => 1)
    two = one.deep_copy
    assert_nil two.id
  end
end
