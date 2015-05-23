require 'test_helper'

class SkillListTest < ActiveSupport::TestCase
  setup do
  end

  test "can translate a simple list - actual skill level" do
    list = Monster::SkillList::FreeformSkillList.new("Stealth-14")
    assert_equal "", list.text
    assert_equal 1, list.list.count
    skill = list.list.first
    assert_equal 14, skill.actual.to_i
    assert_equal "Stealth-14", skill.to_s
  end

  test "can translate a simple list - with modifier" do
    perform_freeform_test "Stealth @DX+1"
  end

  test "can translate a simple list - with TL" do
    perform_freeform_test "Alchemy/TL3 @IQ+1"
  end

  test "can translate a simple list - with required specialization" do
    perform_freeform_test "Animal Handling (Bears) @IQ+1"
  end

  test "can translate a simple list - with TL and specialization" do
    perform_freeform_test "Engineer (Civil)/TL3 @IQ+1"
  end

  test "can translate several skills in a list" do
    list = Monster::SkillList::FreeformSkillList.new("Stealth@DX+1; Acrobatics-14")
    assert_equal "", list.text
    assert_equal 2, list.list.count
  end

  test "can translate several skills in a list in various formats" do
    list = Monster::SkillList::FreeformSkillList.new("Stealth DX+1; Acrobatics=14; Brawling   12; Blowpipe   DX+2;   Detect Lies-Per+1; Camouflage-IQ+1")
    assert_equal "", list.text
    assert_equal 6, list.list.count
  end

  test "cannot translate skills that don't exist in the master skill list" do
    list = Monster::SkillList::FreeformSkillList.new("Ohno; Stealth@DX+1; Crapskill; Acrobatics-14")
    assert_equal 2, list.list.count
    assert_equal "Ohno; Crapskill", list.text
  end
  
  def perform_freeform_test(text)
    list = Monster::SkillList::FreeformSkillList.new(text)
    assert_equal "", list.text
    assert_equal 1, list.list.count
    skill = list.list.first
    assert_equal 1, skill.modifier.to_i
    assert_equal text.to_s, skill.to_s
  end
end
