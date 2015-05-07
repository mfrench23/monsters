require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:skill)
    @monster = FactoryGirl.build(:monster)
  end

  test "prints correctly" do
    assert_equal "Basketweaving @DX+1", @one.to_s
  end
  
  test "modifier as string is formatted [+-]#" do
    assert_equal "+3", Skill::Modifier.new(3).to_s
    assert_equal "-2", Skill::Modifier.new(-2).to_s
    assert_equal "+0", Skill::Modifier.new(0).to_s
  end
  
  test "modifier can modify a stat" do
    m = Skill::Modifier.new(1)
    assert_equal 15, m.actual(14)
    m = Skill::Modifier.new(-1)
    assert_equal 13, m.actual(14)
  end
  
  test "modifier can modify a monster" do
    assert_equal "Basketweaving @DX+1", @one.to_s
    @one.monster = @monster
    assert_equal 10, @one.monster.characteristic_score("DX")
    assert_equal "Basketweaving @DX+1=11", @one.to_s
  end
end
