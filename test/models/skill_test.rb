require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.create(:skill)
  end

  test "prints correctly" do
    assert_equal "Basketweaving @DX+1", @one.to_s
  end
  
  test "modifier as string is formatted [+-]#" do
    assert_equal "+3", Skill::Modifier.new(3).to_s
    assert_equal "-2", Skill::Modifier.new(-2).to_s
    assert_equal "+0", Skill::Modifier.new(0).to_s
  end
end
