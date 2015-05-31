module Creature::SkillList
  class FreeformSkillList < Creature::FreeformList
    attr_accessor :list
    attr_accessor :text

    def initialize(value)
      @list = []
      @text = freeform_break(value).map { |t| translate_skill(t) }.reject { |x| x.nil? }.join(";").strip
    end

    private

    def pull_tech_level(txt)
      tech_level = nil;
      txt.gsub!(/\/TL[\d]+/) { |m| tech_level = m[3..-1]; "" }
      return txt, tech_level
    end

    def pull_characteristic_plus_modifier(txt)
      characteristic = modifier_value = nil;
      txt.gsub!(/(DX|IQ|HT|Will|Per)[+-]\d+/) do |m|
        characteristic = m.gsub(/[+-]\d/) { |x| "" }
        modifier_value = m.gsub(/[^-\d]/) { |x| "" }
        ""
      end
      return txt, characteristic, modifier_value
    end

    def pull_skill_difficulty(txt)
      txt.gsub!(/ \((E|A|H|VH)\)/) { |m| "" }
      return txt
    end

    def pull_skill_price(txt)
      txt.gsub!(/ \[\d+\]/) { |m| "" }
      return txt
    end

    Regex_skill_name = /(?<skill_name>.*?)( \((?<specialization>[^)]*)\))?/
    Regex_actual_value = /(([^\w]+)(?<actual_value>[\d]+))?/
    Regex_notes = /(\((?<notes>[^)]*)\))?/

    def pull_remainder(txt)
      master_skill_name = actual_value = specialization = notes = nil
      if m = txt.match(/^#{Regex_skill_name}#{Regex_actual_value}([^\w]+)?#{Regex_notes}$/)
        master_skill_name = m[:skill_name]
        actual_value = m[:actual_value]
        specialization = m[:specialization]
        notes = m[:notes]
        txt = ""
      end
      return txt, master_skill_name, actual_value, specialization, notes
    end

    def translate_skill(raw_txt)
      txt, tech_level = pull_tech_level(raw_txt.strip)
      txt, characteristic, modifier_value = pull_characteristic_plus_modifier(txt)
      txt, master_skill_name, actual_value, specialization, notes = pull_remainder(pull_skill_price(pull_skill_difficulty(txt)))
      generate_skill(raw_txt, master_skill_name, characteristic, modifier_value, actual_value, specialization, tech_level, notes)
    end

    def generate_skill(raw_txt, master_skill_name, characteristic, modifier_value, actual_value, specialization, tech_level, notes)
      master_skill = MasterSkill.find_by(name: master_skill_name)
      if ! master_skill.nil?
	if (! characteristic.blank?) && (! modifier_value.blank?) && master_skill.characteristic.to_s == characteristic
	  @list << Skill.new(:master_skill => master_skill, :modifier => modifier_value,
	                     :tech_level => tech_level,
	                     :specialization => specialization, :notes => notes)
	  raw_txt = nil
	elsif (! actual_value.blank?)
	  @list << Skill.new(:master_skill => master_skill, :actual => actual_value,
	                     :tech_level => tech_level,
	                     :specialization => specialization, :notes => notes)
	  raw_txt = nil
	end
      end

      raw_txt
    end
  end
end