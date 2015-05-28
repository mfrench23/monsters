require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:skill)
    @creature = FactoryGirl.build(:creature)
  end

  test "prints correctly" do
    assert_equal "Stealth @DX+1", @one.to_s
  end
  
  test "prints correctly with specialization" do
    one = FactoryGirl.build(:skill, master_skill: MasterSkill.find_by(name: "Animal Handling"), specialization: "Rats", modifier: 1)
    assert_equal "Animal Handling (Rats) @IQ+1", one.to_s
  end

  test "prints correctly with TL" do
    one = FactoryGirl.build(:skill, master_skill: MasterSkill.find_by(name: "Alchemy"), tech_level: "3", modifier: 1)
    assert_equal "Alchemy/TL3 @IQ+1", one.to_s
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
    assert_equal "Stealth @DX+1", @one.to_s
    @one.creature = @creature
    assert_equal "Stealth @DX+1=11", @one.to_s
  end

  test "can save monster with a skill with modifier" do
    skill_no_act = FactoryGirl.build(:skill, modifier: 4, actual: nil)
    assert_equal "Stealth @DX+4", skill_no_act.to_s
    @creature.skills << skill_no_act
    assert_equal true, @creature.save
    assert_equal 1, @creature.skills.count
    sk = @creature.skills.first
    assert_equal "Stealth @DX+4=14", sk.to_s
  end

  test "can save a skill with actual, no modifier, and get back a modifier value" do
    skill_no_mod = FactoryGirl.build(:skill, modifier: nil, actual: 14)
    assert_equal "Stealth-14", skill_no_mod.to_s
    assert_equal 0, @creature.skills.count
    @creature.skills << skill_no_mod
    assert_equal true, @creature.save
    sk = @creature.skills.first
    assert_equal "Stealth @DX+4=14", sk.to_s
  end

  test "cannot save a skill without a modifier or an actual value" do
    skill = FactoryGirl.build(:skill, modifier: nil, actual: nil)
    assert_nil skill.modifier
    assert_nil skill.actual
    assert_equal false, skill.validate
    @creature.skills << skill
    assert_equal false, skill.validate
    skill.actual = 12
    assert_equal true, skill.validate
    skill.actual = nil
    assert_equal false, skill.validate
    skill.modifier = 3
    assert_equal true, skill.validate
  end

  test "cannot save a skill without required specialization" do
    master = MasterSkill.find_by(name: "Animal Handling")
    assert_equal true, master.requires_specialization
    skill = FactoryGirl.build(:skill, modifier: 1, master_skill: master)
    assert_equal false, skill.validate
    skill.specialization = "Lions and tigers and bears"
    assert_equal true, skill.validate
  end

  test "cannot save a skill without required TL" do
    master = MasterSkill.find_by(name: "Alchemy")
    assert_equal true, master.requires_tech_level
    skill = FactoryGirl.build(:skill, modifier: 1, master_skill: master)
    assert_equal false, skill.validate
    skill.tech_level = "3"
    assert_equal true, skill.validate
  end

  test "cannot save a skill with TL when not required" do
    master = MasterSkill.find_by(name: "Brawling")
    assert_equal true, (! master.requires_tech_level)
    skill = FactoryGirl.build(:skill, modifier: 1, master_skill: master)
    assert_equal true, skill.validate
    skill.tech_level = "3"
    assert_equal false, skill.validate
  end
end
