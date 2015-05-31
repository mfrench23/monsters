class Creature::FreeformList
  # break on semicolons or commas, ignoring either if inside parenthetical phrases
  def freeform_break(value)
    paren = 0
    value.delete("\n").gsub(/./) do |c|
      paren += ( c == "(" ? 1 : ( c == ")" ? -1 : 0 ) ) # count depth in nested parens
      (c =~ /[;,]/ && paren == 0) ? "\n" : c # break on delimiters outside parenthetical phrases
    end.split("\n")
  end
end