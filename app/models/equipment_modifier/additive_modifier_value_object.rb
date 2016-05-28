# A ModifierValueObject that adds a constant to the value it modifies
class EquipmentModifier::AdditiveModifierValueObject < EquipmentModifier::ModifierValueObject
  def initialize( plus_or_minus, num, is_money )
    @is_money = is_money
    @sign = ( plus_or_minus == "-" ? -1 : 1 )
    @val = ( is_money ? Money.new(num.to_d * 100) : num.to_d )
  end
  def addition(base)
    return @val * @sign
  end
  def factor
    return 1
  end
  def to_s
    (@sign > 0 ? "+" : "-") + (@is_money ? @val.format : "%g" % @val + "#")
  end
end
