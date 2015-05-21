class Monster::FreeformList
  # break on semicolons, ignoring semi's inside parenthetical phrases
  def break_on_semicolons(value)
    paren = 0
    value.delete("\n").gsub(/./) do |c|
      if c == "(" then
	paren += 1
      elsif c == ")" then
	paren -= 1
      elsif c == ";" then
	if paren == 0 then
	  c = "\n"
	end
      end
      c
    end.split("\n")
  end
end