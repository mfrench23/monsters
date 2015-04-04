class Skill::Modifier
  attr_accessor :string

  def initialize(number)
    if number >= 0
      mod = "+"
    end
    @string = mod.to_s + number.to_s
  end

  def to_s
    @string.to_s
  end
end