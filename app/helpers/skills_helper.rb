module SkillsHelper
  def simpleSkill(skill)
    master = skill.master_skill
    name = master.name + " @"
    mod = ""
    if skill.modifier>0
      mod = "+"
    end
    atval = master.baseStat + mod + skill.modifier.to_s

    name + atval
  end
end
