# Represents a GURPS swarm, like a swarm of bees or a horde of rats
class Swarm < Monster
  include NilBlankable

  before_validation :nil_blank_attributes

  private

  def blankable_attributes
    super + [:number_description]
  end
end
