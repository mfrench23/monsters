module Creature::SkillList
  class FreeformSkillList < Creature::FreeformList
    attr_accessor :list
    attr_accessor :text

    def initialize(value)
      @list = []
      @text = freeform_break(value).map { |t| translate_skill(t) }.reject { |x| x.nil? }.join(";").strip
    end

    private

    def pull_tech_level(working_text)
      tech_level = nil;
      working_text.gsub!(/\/TL[\d]+/) { |m| tech_level = m[3..-1]; "" }
      return working_text, tech_level
    end

    Regex_attribute = /(DX|IQ|HT|Will|Per)/

    def pull_characteristic_plus_modifier(working_text)
      characteristic = modifier_value = nil;
      working_text.gsub!(/#{Regex_attribute}([+-]\d+)?/) do |m|
        characteristic = $1
        modifier_value = ( $2.nil? ? "0" : ($2).tr("+"," ").strip )
        ""
      end
      return working_text, characteristic, modifier_value
    end

    def pull_skill_difficulty(working_text)
      working_text.gsub!(/ \((E|A|H|VH)\)/) { |m| "" }
      return working_text
    end

    def pull_skill_price(working_text)
      working_text.gsub!(/ \[\d+\]/) { |m| "" }
      return working_text
    end

    Regex_skill_name = /(?<skill_name>.*?)( \((?<specialization>[^)]*)\))?/
    Regex_actual_value = /(([^\w]+)(?<actual_value>[\d]+))?/
    Regex_notes = /(\((?<notes>[^)]*)\))?/

    def pull_remainder(working_text)
      master_skill_name = actual_value = specialization = notes = nil
      if m = working_text.match(/^#{Regex_skill_name}#{Regex_actual_value}([^\w]+)?#{Regex_notes}$/)
        master_skill_name = m[:skill_name]
        actual_value = m[:actual_value]
        specialization = m[:specialization]
        notes = m[:notes]
        working_text = ""
      end
      return working_text, master_skill_name, actual_value, specialization, notes
    end

    def translate_skill(raw_text)
      working_text, tech_level = pull_tech_level(raw_text.strip)
      working_text, characteristic, modifier_value = pull_characteristic_plus_modifier(working_text)
      working_text, master_skill_name, actual_value, specialization, notes = pull_remainder(pull_skill_price(pull_skill_difficulty(working_text)))
      generate_skill(raw_text, master_skill_name, characteristic, modifier_value, actual_value, specialization, tech_level, notes)
    end

    def generate_skill(raw_text, master_skill_name, characteristic, modifier_value, actual_value, specialization, tech_level, notes)
      master_skill = MasterSkill.find_by(name: master_skill_name)
      if ! master_skill.nil?
	if (! characteristic.blank?) && (! modifier_value.blank?) && master_skill.characteristic.to_s == characteristic
	  @list << Skill.new(:master_skill => master_skill, :modifier => modifier_value,
	                     :tech_level => tech_level,
	                     :specialization => specialization, :notes => notes)
	  raw_text = nil
	elsif (! actual_value.blank?)
	  @list << Skill.new(:master_skill => master_skill, :actual => actual_value,
	                     :tech_level => tech_level,
	                     :specialization => specialization, :notes => notes)
	  raw_text = nil
	end
      end

      raw_text
    end
  end
end