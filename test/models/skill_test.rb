require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  setup do
  end

  test "modifier can modify a monster" do
    skill = Skill.new(:master_skill => MasterSkill.find_by(:name => "Stealth"), :modifier => 1)
    assert_equal "Stealth @DX+1", skill.to_s
    creature = Creature.new
    creature.characteristic_monsters << CharacteristicMonster.new(:characteristic => skill.characteristic, :score => 10 )
    skill.creature = creature
    assert_equal "Stealth @DX+1=11", skill.to_s
  end

  test "prints correctly with specialization" do
    one = Skill.new(master_skill: MasterSkill.find_by(name: "Animal Handling"), specialization: "Rats", modifier: 1)
    assert_equal "Animal Handling (Rats) @IQ+1", one.to_s
  end

  test "prints correctly with TL" do
    one = Skill.new(master_skill: MasterSkill.find_by(name: "Alchemy"), tech_level: "3", modifier: 1)
    assert_equal "Alchemy/TL3 @IQ+1", one.to_s
  end

  test "modifier as string is formatted [+-]#" do
    assert_equal "+3", Skill::Modifier.new(3).to_s
    assert_equal "-2", Skill::Modifier.new(-2).to_s
    assert_equal "+0", Skill::Modifier.new(0).to_s
  end
  
  test "modifier can modify a stat" do
    m = Skill::Modifier.new(1)
    assert_equal "=15", m.actual(14)
    m = Skill::Modifier.new(-1)
    assert_equal "=13", m.actual(14)
  end
  
  test "cannot save a skill without required specialization" do
    master = MasterSkill.find_by(name: "Animal Handling")
    assert_equal true, master.requires_specialization
    skill = Skill.new(:master_skill => master, :modifier => 1)
    assert_equal false, skill.validate
    skill.specialization = "Lions and tigers and bears"
    assert_equal true, skill.validate
  end

  test "cannot save a skill without required TL" do
    master = MasterSkill.find_by(name: "Alchemy")
    assert_equal true, master.requires_tech_level
    skill = Skill.new(:master_skill => master, :modifier => 1)
    assert_equal false, skill.validate
    skill.tech_level = "3"
    assert_equal true, skill.validate
  end

  test "cannot save a skill with TL when not required" do
    master = MasterSkill.find_by(name: "Brawling")
    assert_equal true, (! master.requires_tech_level)
    skill = Skill.new(:master_skill => master, :modifier => 1)
    assert_equal true, skill.validate
    skill.tech_level = "3"
    assert_equal false, skill.validate
  end
end
