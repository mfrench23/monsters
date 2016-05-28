# Represents all the Characteristics appropriate to a particular subclass of Monster
class CharacteristicList < AbstractEntity
  belongs_to :characteristic

  def readonly?
    true
  end

  def self.characteristics_for(monster_type_name)
    Characteristic.joins(:characteristic_lists).where("characteristic_lists.monster_actable_type = '#{monster_type_name}'")
  end
end
