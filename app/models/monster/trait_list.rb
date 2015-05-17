module Monster::TraitList
  def self.getList(value)
    out = break_on_semicolons(value)
    # convert string patterns into Trait objects
    out.map! do |line|
      string_to_trait(line)
    end
    out
  end

  private

  def self.string_to_trait(line)
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

  # break on semicolons, ignoring semi's inside parenthetical phrases
  def self.break_on_semicolons(value)
    paren = 0
    out = []
    value.delete!("\n")
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
    out
  end
end