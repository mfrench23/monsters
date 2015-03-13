require 'test_helper'

class SkillsHelperTest < ActionView::TestCase
  setup do
    @one = FactoryGirl.create(:skill)
  end
  
  test "should format skills" do
    assert_equal "Brawling @DX+1", simpleSkill(@one)
  end
end