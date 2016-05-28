# A ModifierValueObject that makes no actual changes to the values of the thing it modifies
class EquipmentModifier::NoOpModifierValueObject < EquipmentModifier::ModifierValueObject
  def addition(base)
    return 0
  end
  def factor
    return 1
  end
end
