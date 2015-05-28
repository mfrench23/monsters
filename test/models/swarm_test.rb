require 'test_helper'

class SwarmTest < ActiveSupport::TestCase
  test "new swarm starts with basic characteristics" do
    m = Swarm.new
    assert_equal 10, m.characteristic_score("HT")
    assert_equal 10, m.characteristic_score("HP")
    assert_nil m.characteristic_score("DX")
  end
end
