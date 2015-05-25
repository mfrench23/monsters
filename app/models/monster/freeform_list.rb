class Monster::FreeformList
  # break on semicolons or commas, ignoring either if inside parenthetical phrases
  def freeform_break(value)
    paren = 0
    value.delete("\n").gsub(/./) do |c|
      if c == "("
	paren += 1
      elsif c == ")"
	paren -= 1
      elsif c == ";" || c == ","
	if paren == 0
	  c = "\n"
	end
      end
      c
    end.split("\n")
  end
end