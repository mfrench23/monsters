class EquipmentModifier::NoOpModifierValueObject < EquipmentModifier::ModifierValueObject
  def addition(base)
    return 0
  end
  def factor
    return 1
  end
end
