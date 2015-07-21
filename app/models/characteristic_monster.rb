class CharacteristicMonster < AbstractEntity
  belongs_to :characteristic
  belongs_to :monster, touch: true

  def deep_copy
    copy = dup
    copy
  end

  def self.get_instance(characteristic_name, monster)
    ch = CharacteristicList.characteristics_for(monster.actable_type).select {|c| characteristic_name.to_s == c.name }.first
    CharacteristicMonster.new(:characteristic => ch, :monster => monster, :score => ch.base_value) unless ch.nil?
  end
end
