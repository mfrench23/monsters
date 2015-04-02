module Monster::TraitList
  def self.getList(value)
    paren = 0
    out = []
    value.delete!("\n")

    # break on semicolons, ignoring semi's inside parenthetical phrases
    value.scan(/./) do |c|
      if c == "(" then
	paren += 1
	out << c
      elsif c == ")" then
	paren -= 1
	out << c
      elsif c == ";" then
	if paren == 0 then
	  out << "\n"
	else
	  out << c
	end
      else
	out << c
      end
    end

    str = out.join
    out = str.split("\n")

    # convert string patterns into Trait objects
    out.map! do |line|
      line.strip!
      if m = line.match(/^(.*) \((.*)\) ([0-9]*)$/) then
	mt = MasterTrait.find_or_create_by(:name => m[1], :notes => m[2])
	Trait.new(:master_trait => mt, :level => m[3])
      elsif m = line.match(/^(.*) ([0-9][0-9]*)$/) then
	mt = MasterTrait.find_or_create_by(:name => m[1], :notes => nil)
	Trait.new(:master_trait => mt, :level => m[2])
      elsif m = line.match(/^(.*) \((.*)\)$/) then
	mt = MasterTrait.find_or_create_by(:name => m[1], :notes => m[2])
	Trait.new(:master_trait => mt)
      else
	mt = MasterTrait.find_or_create_by(:name => line, :notes => nil)
	Trait.new(:master_trait => mt)
      end
    end
    out
  end
end