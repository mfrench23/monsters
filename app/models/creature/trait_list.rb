module Creature::TraitList
  class FreeformTraitList < Creature::FreeformList
    attr_accessor :list

    def initialize(value)
      out = freeform_break(value)
      @list = out.map { |line| string_to_trait(line) }
    end

    private

    Regex_name = /(?<name>.*?)/
    Regex_level = /( (?<level>[\d]+))?/
    Regex_notes = /( \((?<notes>.*)\))?/
    Regex_price = /( \[[\d]+\])?/

    # convert string patterns into Trait objects
    def string_to_trait(line)
      if m = line.strip.match(/^#{Regex_name}#{Regex_notes}#{Regex_level}#{Regex_price}$/) then
        mt = MasterTrait.find_or_create_by(:name => m[:name], :notes => m[:notes])
        Trait.new(:master_trait => mt, :level => m[:level])
      end
    end
  end
end