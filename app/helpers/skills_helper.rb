module SkillsHelper
  def simpleSkill skill 
    name = skill.name + " @"
    mod = ""
    if skill.modifier>0
      mod = "+"
    end
    atval = skill.baseStat + mod + skill.modifier.to_s
    
    name + atval
  end
end
