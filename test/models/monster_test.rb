require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:monster)
  end

  test "freeform_trait_list adds to master traits - one simple trait" do
    assert_difference "MasterTrait.count" do
      @one.freeform_trait_list="Faketrait"
    end
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
end
