# Represents a GURPS swarm, like a swarm of bees or a horde of rats
class Swarm < AbstractEntity
  has_one :monster, as: :actable
  delegate :ancestry, to: :monster
  delegate :campaign, to: :monster
  delegate :campaign_id, to: :monster
  delegate :description, to: :monster
  delegate :monster_class, to: :monster
  delegate :monster_class_id, to: :monster
  delegate :monster_names, to: :monster
  delegate :name, to: :monster

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
