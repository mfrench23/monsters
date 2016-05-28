# Represents a GURPS swarm, like a swarm of bees or a horde of rats
class Swarm < AbstractEntity
  acts_as :monster
  before_validation :nil_blank_attributes

  def deep_copy
    copy = dup
    copy.monster = monster.deep_copy
    copy
  end

  private

  def nil_blank_attributes
    self[:number_description] = nil if self[:number_description].blank?
  end
end
