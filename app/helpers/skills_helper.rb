module SkillsHelper
  def simpleSkill skill 
    skill.name + " @" + skill.trait + (skill.modifier<0?"":"+") + skill.modifier.to_s
  end
end
