require 'test_helper'

class CreatureTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:creature)
  end

  test "freeform_trait_list adds to master traits - one simple trait" do
    name = "Faketrait"
    assert_difference "MasterTrait.count" do
      @one.freeform_trait_list = name
    end
    mt = MasterTrait.find_by(:name => name)
    assert_equal false, mt.name.blank?
    assert_equal true, mt.notes.blank?
    trait = @one.traits.first
    assert_equal mt, trait.master_trait
    assert_equal true, trait.level.blank?
  end

  test "freeform_trait_list adds to master traits - one trait with level and notes" do
    name = "Bogotrait (Disintegration) 3"
    assert_difference "MasterTrait.count" do
      @one.freeform_trait_list = name
    end
    mt = MasterTrait.find_by(:name => "Bogotrait")
    assert_equal false, mt.name.blank?
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

  test "freeform_trait_list adds to master traits - 2 traits, one complex, delim by comma" do
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (with) 3, Further Arglebargle"
    end
    assert_equal 3, @one.traits.first.level
  end

  test "freeform_trait_list adds to master traits - 2 traits, one with semicolons inside parens and a trailing period" do
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (Dungeon; Urban; Mountain); Exceptional Arglebargle 1."
    end
    assert_equal "Arglebargle", @one.traits.first.master_trait.name
  end
  
  test "cannot save with pending freeform skill entries" do
    assert_equal true, @one.validate
    @one.freeform_skill_list = "garbage entry that isn't a good skill"
    assert_equal false, @one.validate
  end

  test "can save with freeform skill entries that aren't bogus" do
    assert_equal true, @one.validate
    @one.freeform_skill_list = "Stealth@DX+1; Acrobatics-12; Hiking 11; Animal Handling (Big Cats)-12"
    assert_equal true, @one.validate, @one.errors.messages
  end

  test "new creature starts with basic characteristics" do
    m = Creature.new
    assert_not_nil m.characteristic_monster("DX")
    assert_nil m.characteristic_monster("Fake Characteristic")
    assert_equal 10, m.characteristic_score("DX")
  end
end
