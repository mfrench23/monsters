# Intersection between Monster and Characteristic, determining all the characteristic scores
# for a particular monster
class CharacteristicMonster < AbstractEntity
  belongs_to :characteristic
  belongs_to :monster, touch: true

  def deep_copy
    copy = dup
    copy
  end

  def self.get_instance(characteristic_name, monster)
    ch = CharacteristicList.characteristics_for(monster.actable_type).select {|char| characteristic_name.to_s == char.name }.first
    CharacteristicMonster.new(:characteristic => ch, :monster => monster, :score => ch.base_value) if ch.present?
  end
end
