require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.create(:monster)
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
    @one.monster_names << FactoryGirl.create(:monster_name, name: "Don")
    assert_equal @one.names_to_s, "Don"
    @one.monster_names << FactoryGirl.create(:monster_name)
    assert_equal @one.names_to_s, "Bob; Don"
    @one.monster_names << FactoryGirl.create(:monster_name, name: "Celine")
    assert_equal @one.names_to_s, "Bob; Celine; Don"
  end
  
  test "to_s" do
    assert_equal @one.to_s, "Tim the Test Monster"
  end
end
