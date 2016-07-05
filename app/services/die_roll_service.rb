class DieRollService
  def initialize
  end

  # given a die roll formula (like "2d" or "1d/3" or "1d4+1d10"), "roll the dice" and return the result
  def roll(formula_string, min = nil)
    formula = formula_string.to_s.gsub(/ /, "")
    result = (formula.blank? ? 0 : calculate_results(formula))
    min.nil? ? result : ( min > result ? min : result )
  end

  private

  def calculate_results(text)
    # replace all dice expressions of form "dY" with "1dY"
    text = text.gsub(/^d/, "1d").gsub(/([^0-9])d([0-9])/, "#{$1}1d#{$2}")
    # replace "#d" with "#d6"
    text = text.gsub(/d$/, "d6")
    text = text.gsub(/d([^0-9])/) {|match| "d6" + match[1] }
    # replace all dice expressions of form "XdY" with rolled result
    text = text.gsub(/([0-9]+)d([0-9]+)/) { |match| roll_dice(match[0].to_i, match[2].to_i) }
    # perform multiplication and division
    while /(\d+)([*\/])(\d+)/.match(text) do
      text = text.gsub(/(\d+)([*\/])(\d+)/) {|match| match[1] == '*' ? match[0].to_i * match[2].to_i : (match[0].to_f / match[2].to_f).ceil }
    end
    # perform addition and subtraction
    while /(\d+)([+-])(\d+)/.match(text) do
      text = text.gsub(/(\d+)([+-])(\d+)/) {|match| match[1] == '+' ? match[0].to_i + match[2].to_i : match[0].to_i - match[2].to_i }
    end
    text.to_i
  end

  def roll_dice( dice, sides )
    (1..dice).reduce(0) { |result, die_number| result += roll_die(sides) }
  end

  def roll_die(sides)
    1 + rand(sides)
  end
end
