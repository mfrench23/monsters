require 'test_helper'

class CharacteristicListTest < ActiveSupport::TestCase

  test "Gets characteristics of a Creature" do
    assert_equal true, CharacteristicList.characteristics_for("Creature").any?
  end

  test "Gets characteristics of a Swarm" do
    assert_equal true, CharacteristicList.characteristics_for("Swarm").any?
  end

  test "Does not gets characteristics of a Foobar" do
    assert_equal false, CharacteristicList.characteristics_for("Foobar").any?
  end

  test "read only" do
    f = CharacteristicList.first
    assert_equal true, f.readonly?
    f.monster_actable_type = "New Bogus Value"
    assert_raises(ActiveRecord::ReadOnlyRecord) { f.save }
  end
end
