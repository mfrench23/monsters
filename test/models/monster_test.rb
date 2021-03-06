require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  setup do
  end

  test "test starts_with filter" do
    fakename = "Obviously Fake Monster Name"
    one = FactoryBot.create(:monster, name: fakename)
    testval = false;
    Monster.filter(:starting_with => "A").map { |m| if fakename == m.name then testval = true end }
    assert_equal false, testval
    Monster.filter(:starting_with => "O").map { |m| if fakename == m.name then testval = true end }
    assert_equal true, testval
  end

  test "to_s" do
    assert_equal "Tim the Test Monster", Monster.new(:name => "Tim the Test Monster").to_s
  end

  test "Combat Effectiveness Rating calculation" do
    one = Monster.new
    assert_nil one.combat_effectiveness_rating
    one.characteristic_monsters << CharacteristicMonster.new(characteristic: Characteristic.find_by(name: "OR"), score: 17)
    assert_nil one.combat_effectiveness_rating
    one.characteristic_monsters << CharacteristicMonster.new(characteristic: Characteristic.find_by(name: "PR"), score: 21)
    assert_equal 38, one.combat_effectiveness_rating
  end

  test "ancestor's text fields accumulate" do
    campaign = FactoryBot.create(:campaign)
    one = Monster.new(:name => "Tommy", :monster_class => MonsterClass.find_by(:name => "Undead"), :campaign => campaign)
    one.description = "One."
    one.notes = "A"
    one.save!
    two = one.deep_copy
    two.description = "Two."
    two.notes = "B"
    two.save
    three = two.deep_copy
    three.description = "Three."
    three.notes = "C"
    assert_equal "One.\n\nTwo.", two.expanded_field(:description)
    assert_equal "One.\n\nTwo.", three.ancestor_accumulate_field(:description)
    assert_equal "One.", two.ancestor_accumulate_field(:description)
    assert_equal "One.\n\nTwo.\n\nThree.", three.expanded_field(:description)
    assert_equal "A\n\nB\n\nC", three.expanded_field(:notes)
    assert_equal "A", one.expanded_field(:notes)
  end
end
