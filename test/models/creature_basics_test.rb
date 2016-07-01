require 'test_helper'

class CreatureBasicsTest < ActiveSupport::TestCase
  test "new creature starts with basic characteristics" do
    m = Creature.new
    assert_not_nil m.characteristic_monster("DX")
    assert_nil m.characteristic_monster("Fake Characteristic")
    assert_equal 10, m.characteristic_score("DX")
  end
end
