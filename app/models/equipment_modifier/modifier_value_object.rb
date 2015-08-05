class EquipmentModifier::ModifierValueObject
  def self.get_instance(text, is_money = false)
    s = convert_fractions(text.to_s.strip)
    get_cost_factor_modifier_value_object(s, is_money) || get_additive_modifier_value_object(s, is_money) || get_multiplicative_modifier_value_object(s) || NoOpModifierValueObject.new
  end

  private

  Regex_Cost_Factor = /[cC][fF]/
  Regex_Number = /[\d.]+/
  Regex_Money = //
  Regex_PlusOrMinus = /[+-]/
  Regex_Multiplier = /[*x]/

  Regex_Cost_Factor_Modifier = /^(?<pm>#{Regex_PlusOrMinus}) *(?<num>#{Regex_Number}) *#{Regex_Cost_Factor}$/
  Regex_Additive_Modifier = /^(?<pm>#{Regex_PlusOrMinus})[^\d]*(?<num>#{Regex_Number})[^\d]*$/
  Regex_Multiplicative_Modifier = /^#{Regex_Multiplier} *(?<num>#{Regex_Number})$/

  def self.get_multiplicative_modifier_value_object(s)
    if m = s.match( Regex_Multiplicative_Modifier )
      MultiplierModifierValueObject.new(m[:num])
    end
  end

  def self.get_additive_modifier_value_object(s, is_money)
    if m = s.match( Regex_Additive_Modifier )
      AdditiveModifierValueObject.new(m[:pm], m[:num], is_money)
    end
  end

  def self.get_cost_factor_modifier_value_object(s, is_money)
    if m = s.match( Regex_Cost_Factor_Modifier )
      CostFactorModifierValueObject.new(m[:pm], m[:num], is_money)
    end
  end

  def self.convert_fractions(text)
    if m = text.match(/(?<a>#{Regex_Number})\/(?<b>#{Regex_Number})/)
      a = m[:a].to_d
      b = m[:b].to_d
      text.gsub(/#{m[:a]}\/#{m[:b]}/, (a/b).to_s)
    else
      text
    end
  end

  class NoOpModifierValueObject < EquipmentModifier::ModifierValueObject
    def addition(base)
      return 0
    end
    def factor
      return 1
    end
  end

  class MultiplierModifierValueObject < EquipmentModifier::ModifierValueObject
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

  class AdditiveModifierValueObject < EquipmentModifier::ModifierValueObject
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

  class CostFactorModifierValueObject < EquipmentModifier::ModifierValueObject
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
end
