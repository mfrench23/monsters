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