module Creature::TraitList
  class FreeformTraitList
    attr_accessor :list

    def initialize(value)
      out = FreeformList.new(value).freeform_break
      @list = out.map{ |line| string_to_trait(line) }.sort_by{ |trait| [trait.master_trait_name, trait.level] }
    end

    private

    Regex_name = /(?<name>[^(]*?)/
    Regex_level = /( (?<level>[\d]+))/
    Regex_optional_level = /(#{Regex_level})?/
    Regex_notes = /( \((?<notes>.*)\))?/
    Regex_price = /( \[[-\d]+\])?/

    Regex_order1 = /^#{Regex_name}#{Regex_level}#{Regex_notes}#{Regex_price}$/
    Regex_order2 = /^#{Regex_name}#{Regex_notes}#{Regex_optional_level}#{Regex_price}$/

    # convert string patterns into Trait objects
    def string_to_trait(line)
      s = line.strip
      if m = s.match(/^#{Regex_order1}$/) || s.match(/^#{Regex_order2}$/) then
        mt = MasterTrait.find_or_create_by(:name => m[:name])
        Trait.new(:master_trait => mt, :level => m[:level], :notes => m[:notes])
      end
    end
  end

end