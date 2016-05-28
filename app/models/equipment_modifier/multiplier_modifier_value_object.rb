# A ModifierValueObject that multiplies that which is modifies (i.e., "x2")
class EquipmentModifier::MultiplierModifierValueObject < EquipmentModifier::ModifierValueObject
  def initialize( num )
    @val = num.to_d
  end
  def addition(base)
    return 0
  end
  def factor
    return @val
  end
  def to_s
    "x%g" % @val
  end
end