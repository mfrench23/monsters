module Logical
  # A list of items where a semicolon or comma is considered a delimiter unless it
  # falls inside a parenthetical phrase. For example, "one (1, 2); two (3; 5)" would
  # be parsed into two items, "one (1, 2)" and "two (3; 5)". Items may be split across
  # multiple lines of input.
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
      one_line_of_clean_data.gsub(/./) do |clean_data|
        paren_depth += FreeformList.paren_depth_to_add(clean_data) # count depth in nested parens
        FreeformList.break_on_delimiters(clean_data, paren_depth) # break on delimiters outside parenthetical phrases
      end.split("\n")
    end

    def self.break_on_delimiters(text, paren_depth)
      (text =~ /[;,]/ && paren_depth == 0) ? "\n" : text
    end

    def self.paren_depth_to_add(text)
      ( text == "(" ? 1 : ( text == ")" ? -1 : 0 ) )
    end

    def one_line_of_clean_data
      @value = transform_to_one_line.gsub(/\.$/){ "" }
    end

    def transform_to_one_line
      @value.delete("\n")
    end
  end
end