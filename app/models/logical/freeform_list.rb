# A list of items where a semicolon or comma is considered a delimiter unless it
# falls inside a parenthetical phrase. For example, "one (1, 2); two (3; 5)" would
# be parsed into two items, "one (1, 2)" and "two (3; 5)". Items may be split across
# multiple lines of input.
module Logical
  class FreeformList
    attr_accessor :list

    def initialize(value)
      @value = value
      @list = freeform_break
    end

    private

    # break on semicolons or commas, ignoring either if inside parenthetical phrases
    def freeform_break
      paren_depth = 0
      one_line_of_clean_data.gsub(/./) do |c|
        paren_depth += paren_depth_to_add(c) # count depth in nested parens
        break_on_delimiters(c, paren_depth) # break on delimiters outside parenthetical phrases
      end.split("\n")
    end

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
end