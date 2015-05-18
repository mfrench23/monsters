module Monster::TraitList
  class FreeformTraitList < Monster::FreeformList
    attr_accessor :list

    def initialize(value)
      out = break_on_semicolons(value)
      # convert string patterns into Trait objects
      out.map! do |line|
	string_to_trait(line)
      end
      @list = out
    end

    private

    def string_to_trait(line)
      sline = line.strip
      if m = sline.match(/^(.*) \((.*)\) ([0-9]*)$/) then
	mt = MasterTrait.find_or_create_by(:name => m[1], :notes => m[2])
	retval = Trait.new(:master_trait => mt, :level => m[3])
      elsif m = sline.match(/^(.*) ([0-9][0-9]*)$/) then
	mt = MasterTrait.find_or_create_by(:name => m[1], :notes => nil)
	retval = Trait.new(:master_trait => mt, :level => m[2])
      elsif m = sline.match(/^(.*) \((.*)\)$/) then
	mt = MasterTrait.find_or_create_by(:name => m[1], :notes => m[2])
	retval = Trait.new(:master_trait => mt)
      else
	mt = MasterTrait.find_or_create_by(:name => sline, :notes => nil)
	retval = Trait.new(:master_trait => mt)
      end
      retval
    end
  end
end