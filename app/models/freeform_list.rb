class FreeformList
  def initialize(value)
    @value = value
  end

  # break on semicolons or commas, ignoring either if inside parenthetical phrases
  def freeform_break
    paren_depth = 0
    one_line_of_clean_data.gsub(/./) do |c|
      paren_depth += paren_depth_to_add(c) # count depth in nested parens
      break_on_delimiters(c, paren_depth) # break on delimiters outside parenthetical phrases
    end.split("\n")
  end

  private

  def break_on_delimiters(c, paren_depth)
    (c =~ /[;,]/ && paren_depth == 0) ? "\n" : c
  end

  def paren_depth_to_add(c)
    ( c == "(" ? 1 : ( c == ")" ? -1 : 0 ) )
  end

  def one_line_of_clean_data
    @value = transform_to_one_line.gsub(/\.$/){ "" }
  end

  def transform_to_one_line
    @value.delete("\n")
  end
end