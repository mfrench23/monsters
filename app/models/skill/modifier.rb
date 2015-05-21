class Skill::Modifier
  attr_accessor :string
  attr_accessor :modval

  def initialize(number)
    if (! number.to_s.empty?) && (number >= 0)
      mod = "+"
    end
    @string = mod.to_s + number.to_s
    @modval = number
  end

  def to_s
    @string.to_s
  end

  def actual(score)
    return (score.to_s.empty? ? nil : score+modval)
  end
end