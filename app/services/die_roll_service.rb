class DieRollService
  def initialize
  end

  # given a die roll formula (like "2d" or "1d/3" or "1d4+1d10"), "roll the dice" and return the result
  def roll(formula_string, min = nil)
    formula = formula_string.to_s.gsub(/ /, "")
    result = (formula.blank? ? 0 : calculate_results(formula).to_i)
    min.nil? ? result : ( min > result ? min : result )
  end

  private

  Regex_Parenthetical_Phrase = /\(([^()]+)\)/
  Regex_Die_Roll = /([0-9]+)d([0-9]+)/
  Regex_Add_Or_Subtract = /(\d+)([+-])(\d+)/
  Regex_Multiply_Or_Divide = /(\d+)([*\/])(\d+)/

  def calculate_results(text)
    text = calculate_parenthetic_phrases(text)
    text = normalize_dice_expressions(text)
    text = roll_the_dice(text)
    text = do_the_math(text)
    text
  end

  def calculate_parenthetic_phrases(text)
    while Regex_Parenthetical_Phrase.match(text) do
      text = text.gsub(Regex_Parenthetical_Phrase) do |match|
        calculate_results($1)
      end
    end
    text
  end

  def roll_the_dice(text)
    # replace all dice expressions of form "XdY" with rolled result
    text.gsub(Regex_Die_Roll) { |match| roll_dice($1.to_i, $2.to_i) }
  end

  def do_the_math(text)
    text = multiply_and_divide(text)
    add_and_subtract(text)
  end

  def add_and_subtract(text)
    # perform addition and subtraction, left to right
    while text.match(Regex_Add_Or_Subtract) do
      text = text.gsub(Regex_Add_Or_Subtract) do |match|
        $2 == '+' ? $1.to_i + $3.to_i : $1.to_i - $3.to_i
      end
    end
    text
  end

  def multiply_and_divide(text)
    # perform multiplication and division, left to right
    while text.match(Regex_Multiply_Or_Divide) do
      text = text.gsub(Regex_Multiply_Or_Divide) do |match|
        $2 == '*' ? ($1.to_i * $3.to_i) : ($1.to_f / $3.to_f).ceil
      end
    end
    text
  end

  def normalize_dice_expressions(text)
    # replace all dice expressions of form "dY" with "1dY"
    text = text.gsub(/^d/, "1d").gsub(/([^0-9])d([0-9])/, "#{$1}1d#{$2}")
    # replace "#d" with "#d6"
    text = text.gsub(/d$/, "d6")
    text.gsub(/d([^0-9])/) {|match| "d6" + $1 }
  end

  def roll_dice( dice, sides )
    (1..dice).reduce(0) { |result, die_number| result += roll_die(sides) }
  end

  def roll_die(sides)
    1 + rand(sides)
  end
end
