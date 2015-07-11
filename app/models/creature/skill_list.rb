module Creature::SkillList
  class FreeformSkillList < Creature::FreeformList
    attr_accessor :list
    attr_accessor :text

    def initialize(value)
      @list = []
      array_of_remainders = freeform_break(value).map { |t| add_to_list_returning_remaining_text t }
      @text = array_of_remainders.reject { |x| x.nil? }.join(";").strip
    end

    private

    def add_to_list_returning_remaining_text(text)
        s = SkillText.new(text)
        @list << s.skill unless s.skill.nil?
        s.remaining_text
    end
  end

  class SkillText
    attr_accessor :remaining_text
    attr_accessor :skill

    def initialize(raw_text)
      @remaining_text = raw_text
      @working_text = raw_text.strip
      pull_tech_level
      pull_characteristic_plus_modifier
      pull_skill_difficulty
      pull_skill_price
      pull_remainder
      generate_skill
    end

    private

    Regex_skill_name = /(?<skill_name>.*?)( \((?<specialization>[^)]*)\))?/
    Regex_actual_value = /(([^\w]+)(?<actual_value>[\d]+))?/
    Regex_notes = /(\((?<notes>[^)]*)\))?/
    Regex_attribute = /(DX|IQ|HT|Will|Per)/

    def pull_tech_level
      @working_text.gsub!(/\/TL[\d]+/) { |m| @tech_level = m[3..-1]; "" }
    end

    def pull_characteristic_plus_modifier
      @working_text.gsub!(/#{Regex_attribute}([+-]\d+)?/) do |m|
        @characteristic = $1
        @modifier_value = ( $2.nil? ? "0" : ($2).tr("+"," ").strip )
        ""
      end
    end

    def pull_skill_difficulty
      @working_text.gsub!(/ \((E|A|H|VH)\)/) { |m| "" }
    end

    def pull_skill_price
      @working_text.gsub!(/ \[\d+\]/) { |m| "" }
    end

    def pull_remainder
      if m = @working_text.match(/^#{Regex_skill_name}#{Regex_actual_value}([^\w]+)?#{Regex_notes}$/)
        @master_skill_name = m[:skill_name]
        @actual_value = m[:actual_value]
        @specialization = m[:specialization]
        @notes = m[:notes]
      end
    end

    def generate_skill
      master_skill = MasterSkill.find_by(name: @master_skill_name)
      if ! master_skill.nil?
        if (! @characteristic.blank?) && (! @modifier_value.blank?) && master_skill.characteristic.to_s == @characteristic
          build_skill_from_characteristic_and_modifier(master_skill)
        elsif (! @actual_value.blank?)
          build_skill_from_actual(master_skill)
        end
      end
    end

    def build_skill_from_actual(master_skill)
      @skill = Skill.new(:master_skill => master_skill, :actual => @actual_value,
                          :tech_level => @tech_level,
                          :specialization => @specialization, :notes => @notes)
      @remaining_text = nil
    end

    def build_skill_from_characteristic_and_modifier(master_skill)
      @skill = Skill.new(:master_skill => master_skill, :modifier => @modifier_value,
                          :tech_level => @tech_level,
                          :specialization => @specialization, :notes => @notes)
      @remaining_text = nil
    end
  end
end