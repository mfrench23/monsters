require 'test_helper'

class SwarmTest < ActiveSupport::TestCase
  test "new swarm starts with basic characteristics" do
    m = Swarm.new
    assert_equal 10, m.characteristic_score("HT")
    assert_equal 10, m.characteristic_score("HP")
    assert_nil m.characteristic_score("DX")
  end

  test "can deep_copy" do
    one = Swarm.new(:name => "Swarm of Fnords", :monster_class => MonsterClass.first)
    one.characteristic_monsters << CharacteristicMonster.new(:characteristic => Characteristic.find_by(:name => "HT"))
    one.characteristic_monsters.first.score = 10
    assert_equal true, one.root?
    assert_equal true, one.save
    assert_equal false, one.has_children?
    assert_equal 10, (one.characteristic_score "HT")
    copy = one.deep_copy
    copy.characteristic_monsters.first.score = 20
    assert_equal true, copy.save
    assert_equal true, one.has_children?
    assert_equal one, copy.parent.specific
    one_loaded = Swarm.find(one.id)
    assert_equal 10, (one_loaded.characteristic_score "HT")
  end
end
