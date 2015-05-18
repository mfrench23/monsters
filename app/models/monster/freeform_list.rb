class Monster::FreeformList
  # break on semicolons, ignoring semi's inside parenthetical phrases
  def break_on_semicolons(value)
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