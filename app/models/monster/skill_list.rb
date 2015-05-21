module Monster::SkillList
  class FreeformSkillList < Monster::FreeformList
    attr_accessor :list
    attr_accessor :text

    def initialize(value)
      @list = []
      out = break_on_semicolons(value)
      out.map! do |skill_text|
	translate_skill(skill_text)
      end
      out = out.reject { |x| x.nil? }
      @text = out.join(";").strip
    end

    private

    def translate_skill(raw_txt)
      txt = raw_txt.strip
      if m = txt.match(/^([a-zA-Z0-9\- ]*)[^a-zA-Z0-9]+([a-zA-Z][a-zA-Z]+) *([+-][0-9]+)$/) then
	master_skill_name = m[1]
	characteristic = m[2]
	modifier_value = m[3]
	raw_txt = generate_skill(raw_txt, master_skill_name, characteristic, modifier_value, nil)
      elsif m = txt.match(/^([a-zA-Z0-9\-]*)[^a-zA-Z0-9]+([0-9]+)$/) then
	master_skill_name = m[1]
	actual_value = m[2]
	raw_txt = generate_skill(raw_txt, master_skill_name, nil, nil, actual_value)
      end
      raw_txt
    end

    def generate_skill(raw_txt, master_skill_name, characteristic, modifier_value, actual_value)
      master_skill = MasterSkill.find_by(name: master_skill_name)
      if ! master_skill.nil?
	if (! characteristic.to_s.empty?) && (! modifier_value.to_s.empty?) && master_skill.characteristic.to_s == characteristic
	  @list << Skill.new(:master_skill => master_skill, :modifier => modifier_value)
	  raw_txt = nil
	elsif (! actual_value.to_s.empty?)
	  @list << Skill.new(:master_skill => master_skill, :actual => actual_value)
	  raw_txt = nil
	end
      end

      raw_txt
    end
  end
end