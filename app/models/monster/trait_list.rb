module Monster::TraitList
  class FreeformTraitList < Monster::FreeformList
    attr_accessor :list

    def initialize(value)
      out = break_on_semicolons(value)
      @list = out.map { |line| string_to_trait(line) }
    end

    private

    # convert string patterns into Trait objects
    def string_to_trait(line)
      sline = line.strip
      if m = sline.match(/^(.*) \((.*)\) ([0-9]*)$/) then
	name = m[1]
	notes = m[2]
	level = m[3]
      elsif m = sline.match(/^(.*) ([0-9][0-9]*)$/) then
	name = m[1]
	level = m[2]
      elsif m = sline.match(/^(.*) \((.*)\)$/) then
	name = m[1]
	notes = m[2]
      else
	name = sline
      end
      mt = MasterTrait.find_or_create_by(:name => name, :notes => notes)
      Trait.new(:master_trait => mt, :level => level)
    end
  end
end