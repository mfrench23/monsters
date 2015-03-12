require 'test_helper'

class MonsterNameTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.create(:monster_name)
    @two = FactoryGirl.create(:monster_name, name: "Don", primary: false)
    @three = FactoryGirl.create(:monster_name, name: "Zed", primary: true)
  end
  
  test "comparison" do
    assert_equal nil, @one <=> "Fish"
    assert_equal nil, "Fish" <=> @one
    assert_equal 0, @one <=> @one
    assert_equal -1, @one <=> @two
    assert_equal 1, @two <=> @one
    assert_equal -1, @three <=> @two
  end
end
