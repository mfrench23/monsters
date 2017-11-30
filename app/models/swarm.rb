# Represents a GURPS swarm, like a swarm of bees or a horde of rats
class Swarm < Monster
  before_validation :nil_blank_attributes

  private

  def nil_blank_attributes
    self[:number_description] = nil if self[:number_description].blank?
  end
end
