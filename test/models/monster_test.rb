require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:monster)
  end

  test "test starts_with filter" do
    fakename = "Obviously Fake Monster Name"
    one = FactoryGirl.create(:monster, name: fakename)
    testval = false;
    Monster.filter(:starting_with => "A").map { |m| if fakename == m.name then testval = true end }
    assert_equal false, testval
    Monster.filter(:starting_with => "O").map { |m| if fakename == m.name then testval = true end }
    assert_equal true, testval
  end

  test "to_s" do
    assert_equal @one.to_s, "Tim the Test Monster"
  end

  test "Combat Effectiveness Rating calculation" do
    assert_nil @one.combat_effectiveness_rating
    @one.characteristic_monsters << CharacteristicMonster.new(characteristic: Characteristic.find_by(name: "OR"), score: 17)
    assert_nil @one.combat_effectiveness_rating
    @one.characteristic_monsters << CharacteristicMonster.new(characteristic: Characteristic.find_by(name: "PR"), score: 21)
    assert_equal 38, @one.combat_effectiveness_rating
  end
end
