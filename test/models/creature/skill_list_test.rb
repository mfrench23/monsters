require 'test_helper'

class SkillListTest < ActiveSupport::TestCase
  setup do
  end

  test "can translate a simple list - actual skill level" do
    list = Creature::SkillList::FreeformSkillList.new("Stealth-14")
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

  test "can translate a simple list - with required specialization and optional notes" do
    skill = perform_freeform_test "Animal Handling (Bears) @IQ+1 (+1 with picnic basket)"
    assert_equal "+1 with picnic basket", skill.notes
  end

  test "can translate a simple list - with TL and specialization" do
    perform_freeform_test "Engineer (Civil)/TL3 @IQ+1"
  end

  test "can translate several skills in a list" do
    list = Creature::SkillList::FreeformSkillList.new("Stealth@DX+1; Acrobatics-14")
    assert_equal "", list.text
    assert_equal 2, list.list.count
  end

  test "can translate several skills in a list in various formats" do
    list = Creature::SkillList::FreeformSkillList.new("Stealth DX+1, Acrobatics=14 (conditional +2 for Being Cool); Brawling   12; Blowpipe   DX+2;   Detect Lies-Per+1; Camouflage-IQ+1")
    assert_equal "", list.text
    assert_equal 6, list.list.count
  end

  test "cannot translate skills that don't exist in the master skill list" do
    list = Creature::SkillList::FreeformSkillList.new("Ohno; Stealth@DX+1; Crapskill; Acrobatics-14")
    assert_equal 2, list.list.count
    assert_equal "Ohno; Crapskill", list.text
  end
  
  test "complex skill format" do
    list = Creature::SkillList::FreeformSkillList.new("Brawling (E) DX+2 [4]-12; Psychology (Human) (H) IQ-1 [2]-9")
    assert_equal "", list.text
    assert_equal 2, list.list.count
    skill = list.list.first
    assert_equal 2, skill.modifier.to_i
    assert_equal "Brawling @DX+2".to_s, skill.to_s
    skill = list.list.last
    assert_equal -1, skill.modifier.to_i
    assert_equal "Human", skill.specialization
    assert_equal "Psychology", skill.master_skill.name
  end

  def perform_freeform_test(text)
    list = Creature::SkillList::FreeformSkillList.new(text)
    assert_equal "", list.text
    assert_equal 1, list.list.count
    skill = list.list.first
    assert_equal 1, skill.modifier.to_i
    assert_equal text.to_s, skill.to_s
    skill
  end
end
