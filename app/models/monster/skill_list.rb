module Monster::SkillList
  class FreeformSkillList < Monster::FreeformList
    attr_accessor :list
    attr_accessor :text

    def initialize(value)
      @list = []
      @text = break_on_semicolons(value).map { |t| translate_skill(t) }.reject { |x| x.nil? }.join(";").strip
    end

    private

    def translate_skill(raw_txt)
      txt = raw_txt.strip
      regex_specialization = /( \((?<specialization>[^)]*)\))?/
      regex_tl = /(\/TL(?<tech_level>[\d]+))?/
      regex_skill_name = /(?<skill_name>[\w\- ]+)#{regex_specialization}#{regex_tl}/
      regex_characteristic_name = /(?<characteristic>[a-zA-Z]{2,})/
      regex_modifier_value = /(?<modifier_value>[+-][\d]+)/
      regex_actual_value = /(?<actual_value>[\d]+)/
      sep = /[^\w]+/
      if m = txt.match(/^#{regex_skill_name}#{sep}#{regex_characteristic_name} *#{regex_modifier_value}$/)
	master_skill_name = m[:skill_name]
	characteristic = m[:characteristic]
	modifier_value = m[:modifier_value]
	specialization = m[:specialization]
	tech_level = m[:tech_level]
      elsif m = txt.match(/^#{regex_skill_name}#{sep}#{regex_actual_value}$/)
	master_skill_name = m[:skill_name]
	actual_value = m[:actual_value]
	specialization = m[:specialization]
	tech_level = m[:tech_level]
      end
      generate_skill(raw_txt, master_skill_name, characteristic, modifier_value, actual_value, specialization, tech_level)
    end

    def generate_skill(raw_txt, master_skill_name, characteristic, modifier_value, actual_value, specialization, tech_level)
      master_skill = MasterSkill.find_by(name: master_skill_name)
      if ! master_skill.nil?
	if (! characteristic.to_s.empty?) && (! modifier_value.to_s.empty?) && master_skill.characteristic.to_s == characteristic
	  @list << Skill.new(:master_skill => master_skill, :modifier => modifier_value,
	                     :tech_level => tech_level,
	                     :specialization => specialization)
	  raw_txt = nil
	elsif (! actual_value.to_s.empty?)
	  @list << Skill.new(:master_skill => master_skill, :actual => actual_value,
	                     :tech_level => tech_level,
	                     :specialization => specialization)
	  raw_txt = nil
	end
      end

      raw_txt
    end
  end
end