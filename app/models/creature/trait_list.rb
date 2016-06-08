module Creature::TraitList
  # Represents (and parses) several Traits encoded into a single string of data and abbreviations
  class FreeformTraitList
    attr_accessor :list

    def initialize(value)
      out = Logical::FreeformList.new(value).list
      @list = out.map{ |line| FreeformTraitList.string_to_trait(line) }.sort_by{ |trait| [trait.master_trait_name, trait.level] }
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
    def self.string_to_trait(line)
      stripped_string = line.strip
      if match = stripped_string.match(/^#{Regex_order1}$/) || stripped_string.match(/^#{Regex_order2}$/) then
        master = MasterTrait.find_or_create_by(:name => match[:name])
        Trait.new(:master_trait => master, :level => match[:level], :notes => match[:notes])
      end
    end
  end

end