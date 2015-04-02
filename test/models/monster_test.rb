require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.create(:monster)
  end

  test "freeform_trait_list adds to master traits" do
    assert_equal "", @one.freeform_trait_list
    assert_difference "MasterTrait.count" do
      @one.freeform_trait_list="Faketrait"
    end
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (with) 3; Further Arglebargle"
    end
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (Dungeon; Urban; Mountain); Exceptional Arglebargle 1"
    end
  end
end
