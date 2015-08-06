class EquipmentModifier::CostFactorModifierValueObject < EquipmentModifier::ModifierValueObject
  def initialize( plus_or_minus, num, is_money )
    @is_money = is_money
    @sign = ( plus_or_minus == "-" ? -1 : 1 )
    @val = num.to_d
  end
  def addition(base)
    return base * @val * @sign
  end
  def factor
    return 1
  end
  def to_s
    (@sign > 0 ? "+" : "-") + ("%g" % @val) + " CF"
  end
end