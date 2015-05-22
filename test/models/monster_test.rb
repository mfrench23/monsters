require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:monster)
  end

  test "freeform_trait_list adds to master traits - one simple trait" do
    name = "Faketrait"
    assert_difference "MasterTrait.count" do
      @one.freeform_trait_list = name
    end
    mt = MasterTrait.find_by(:name => name)
    assert_equal false, mt.name.to_s.empty?
    assert_equal true, mt.notes.to_s.empty?
    trait = @one.traits.first
    assert_equal mt, trait.master_trait
    assert_equal true, trait.level.to_s.empty?
  end

  test "freeform_trait_list adds to master traits - one trait with level and notes" do
    name = "Bogotrait (Disintegration) 3"
    assert_difference "MasterTrait.count" do
      @one.freeform_trait_list = name
    end
    mt = MasterTrait.find_by(:name => "Bogotrait")
    assert_equal false, mt.name.to_s.empty?
    assert_equal "Disintegration", mt.notes
    trait = @one.traits.first
    assert_equal mt, trait.master_trait
    assert_equal "3", trait.level.to_s
  end

  test "freeform_trait_list adds to master traits - 2 traits, one complex" do
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (with) 3; Further Arglebargle"
    end
  end

  test "freeform_trait_list adds to master traits - 2 traits, one with semicolons inside parens" do
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (Dungeon; Urban; Mountain); Exceptional Arglebargle 1"
    end
  end
  
  test "names_to_s" do
    @one.monster_names << FactoryGirl.build(:monster_name, name: "Don")
    assert_equal @one.names_to_s, "Don"
    @one.monster_names << FactoryGirl.build(:monster_name)
    assert_equal @one.names_to_s, "Bob; Don"
    @one.monster_names << FactoryGirl.build(:monster_name, name: "Celine")
    assert_equal @one.names_to_s, "Bob; Celine; Don"
  end
  
  test "to_s" do
    assert_equal @one.to_s, "Tim the Test Monster"
  end

  test "cannot save with pending freeform skill entries" do
    assert_equal true, @one.validate
    @one.freeform_skill_list = "garbage entry that isn't a good skill"
    assert_equal false, @one.validate
  end

  test "can save with freeform skill entries that aren't bogus" do
    assert_equal true, @one.validate
    @one.freeform_skill_list = "Stealth@DX+1; Acrobatics-12; Hiking 11"
    assert_equal true, @one.validate
  end

  test "Combat Effectiveness Rating calculation" do
    assert_nil @one.combat_effectiveness_rating
    @one.characteristic_monsters << CharacteristicMonster.new(characteristic: Characteristic.find_by(name: "OR"), score: 17)
    assert_nil @one.combat_effectiveness_rating
    @one.characteristic_monsters << CharacteristicMonster.new(characteristic: Characteristic.find_by(name: "PR"), score: 21)
    assert_equal 38, @one.combat_effectiveness_rating
  end
end
